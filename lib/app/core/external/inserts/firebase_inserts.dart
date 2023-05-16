import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../lyric/infra/adapters/firestore-dtos/lyric_dto_adapter.dart';
import '../../../lyric/infra/adapters/firestore-dtos/service_dto_adapter.dart';
import '../../../../firebase_options.dart';
import '../../../lyric/infra/adapters/firestore-dtos/settings_dto_adapter.dart';
import '../../../lyric/infra/models/firestore-dtos/lyric_dto.dart';
import '../../../lyric/infra/models/firestore-dtos/service_dto.dart';
import '../../../lyric/infra/models/firestore-dtos/settings_dto.dart';
import '../../../shared/components/utils/service_util.dart';
import '../firestore_datasource.dart';

// ignore_for_file: avoid_print
Future<void> firebaseInitialize() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (details) {
    log(
      details.exceptionAsString(),
      stackTrace: details.stack,
    );
  };
}

void main() async {
  await firebaseInitialize();

  FirestoreDatasource fire =
      FirestoreDatasource(firestore: FirebaseFirestore.instance);
  // String servicesCollectionUrl = 'services-collection';
  String lyricsUrl = 'lyrics';
  String settingsUrl = 'settings/QJ70H5A2gNCrnwgHq5cB';
  String saturdayServiceUrl = 'saturday-services/xgvMavJww017MmVK54A9';
  String morningSundayServiceUrl = 'morning-sunday-services';
  String eveningSundayServiceUrl = 'evening-sunday-services';

  try {
    final String saturdayJson = await rootBundle
        .loadString('assets/data/saturday-services/saturday-service.json');
    final String sundayEveningJson = await rootBundle.loadString(
        'assets/data/sunday-evening-services/sunday-evening-service.json');
    final String sundayMorningJson = await rootBundle.loadString(
        'assets/data/sunday-morning-services/sunday-morning-service.json');
    /*List<Map<String, dynamic>> servicesCollection = [
      {
        'id':'1',
        'title': 'Sábado à noite',
        'heading': 'sábado à noite (UMP)',
        'image': 'assets/images/saturday_evening.png',
        'path': 'saturday-services/20',
        'hour': '19h30'
      },
      {
        'id':'2',
        'title': 'Domingo pela manhã',
        'heading': 'domingo pela manhã',
        'image': 'assets/images/sunday_morning.jpg',
        'path': 'morning-sunday-services/20',
        'hour': '9h'
      },
      {
        'id':'3',
        'title': 'Domingo à noite',
        'heading': 'domingo à noite',
        'image': 'assets/images/sunday_evening.png',
        'path': 'evening-sunday-services/20',
        'hour': '19h'
      },
    ];*/

    List<ServiceDTO> services = [];
    List<ServiceDTO> servicesAux = [];
    List<LyricDTO> allLyricsInserted = [];

    services.add(ServiceDTOAdapter.fromJson(saturdayJson));
    services.add(ServiceDTOAdapter.fromJson(sundayEveningJson));
    services.add(ServiceDTOAdapter.fromJson(sundayMorningJson));

    for (int column = 0; services.length > column; column++) {
      ServiceDTO service =
          await ServiceUtil.generateService(services[column], column);
      allLyricsInserted.addAll(service.lyricsList);
      servicesAux.add(service);
    }

    for (LyricDTO lyric in allLyricsInserted) {
      fire.add(lyricsUrl, LyricDTOAdapter.toMap(lyric));
    }

    print('Total number of lyrics inserted: ${allLyricsInserted.length}');

    fire.add(saturdayServiceUrl, ServiceDTOAdapter.toMap(servicesAux[0]));
    fire.add(eveningSundayServiceUrl, ServiceDTOAdapter.toMap(servicesAux[1]));
    fire.add(morningSundayServiceUrl, ServiceDTOAdapter.toMap(servicesAux[2]));

    print('Services and lyrics have been added successfully');

    /* for (Map collection in servicesCollection) {
      fire.add(servicesCollectionUrl, collection);
    }
    //print('Services Collection have been added successfully');
*/
    fire.add(
        settingsUrl,
        SettingsDTOAdapter.toMap(
            SettingsDTO(fireUpdateId: ServiceUtil.createId(8))));
    print('updateAt have been updated successfully');
  } catch (e) {
    //print('$e');
  }
}
