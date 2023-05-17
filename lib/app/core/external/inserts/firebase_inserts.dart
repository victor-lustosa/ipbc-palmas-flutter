import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../firestore_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../../shared/components/utils/service_util.dart';
import '../../../lyric/infra/models/firestore-dtos/lyric_dto.dart';
import '../../../lyric/infra/models/firestore-dtos/service_dto.dart';
import '../../../lyric/infra/models/firestore-dtos/settings_dto.dart';
import '../../../lyric/infra/adapters/firestore-dtos/lyric_dto_adapter.dart';
import '../../../lyric/infra/adapters/firestore-dtos/collection_dto_adapter.dart';
import '../../../lyric/infra/adapters/firestore-dtos/settings_dto_adapter.dart';
import '../../../../firebase_options.dart';

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
dateNowDelayed() async{
  return Future.delayed(const Duration(seconds: 2),() => DateTime.now());
}
void main() async {
  await firebaseInitialize();

  FirestoreDatasource fire = FirestoreDatasource(firestore: FirebaseFirestore.instance);
  String lyricsUrl = 'lyrics';
  String servicesUrl = 'services';
  String saturdayServiceUrl = 'saturday-services';
  String settingsUrl = 'settings/xgvMavJww017MmVK54A9';
  String sundayMorningServiceUrl = 'sunday-morning-services';
  String sundayEveningServiceUrl = 'sunday-evening-services';

  try {
    final String saturdayJson = await rootBundle.loadString('assets/data/saturday-services/saturday-service.json');
    final String sundayEveningJson = await rootBundle.loadString('assets/data/sunday-evening-services/sunday-evening-service.json');
    final String sundayMorningJson = await rootBundle.loadString('assets/data/sunday-morning-services/sunday-morning-service.json');

    List<Map<String, dynamic>> services = [
      {
        'id': ServiceUtil.createId(8),
        'title': 'Domingo à noite',
        'heading': 'domingo à noite',
        'createAt': await dateNowDelayed(),
        'image': 'assets/images/sunday_evening.png',
        'path': 'sunday-evening-services/20',
        'hour': '19h'
      },
      {
        'id': ServiceUtil.createId(8),
        'title': 'Domingo pela manhã',
        'heading': 'domingo pela manhã',
        'createAt': await dateNowDelayed(),
        'image': 'assets/images/sunday_morning.jpg',
        'path': 'sunday-morning-services/20',
        'hour': '9h'
      },
      {
        'id': ServiceUtil.createId(8),
        'title': 'Sábado à noite',
        'createAt': await dateNowDelayed(),
        'heading': 'sábado à noite (UMP)',
        'image': 'assets/images/saturday_evening.png',
        'path': 'saturday-services/20',
        'hour': '19h30'
      },
    ];

    List<ServiceDTO> servicesCollection = [];
    List<ServiceDTO> servicesCollectionAux = [];
    List<LyricDTO> allLyricsInserted = [];

    servicesCollection.add(CollectionDTOAdapter.fromJson(saturdayJson));
    servicesCollection.add(CollectionDTOAdapter.fromJson(sundayEveningJson));
    servicesCollection.add(CollectionDTOAdapter.fromJson(sundayMorningJson));

    for (int column = 0; servicesCollection.length > column; column++) {
      ServiceDTO service = await ServiceUtil.generateService(servicesCollection[column], column);
      allLyricsInserted.addAll(service.lyricsList);
      servicesCollectionAux.add(service);
    }
    for (LyricDTO lyric in allLyricsInserted) {
      fire.add(lyricsUrl, LyricDTOAdapter.toMap(lyric));
    }

    print('Total number of lyrics inserted: ${allLyricsInserted.length}');

    fire.add(saturdayServiceUrl, CollectionDTOAdapter.toMap(servicesCollectionAux[0]));
    fire.add(sundayEveningServiceUrl, CollectionDTOAdapter.toMap(servicesCollectionAux[1]));
    fire.add(sundayMorningServiceUrl, CollectionDTOAdapter.toMap(servicesCollectionAux[2]));

    print('Collection and lyrics have been added successfully');

     for (Map service in services) {
      fire.add(servicesUrl, service);
    }

    print('Services have been added successfully');
    fire.update(
        settingsUrl,
        SettingsDTOAdapter.toMap(SettingsDTO(fireUpdateId: ServiceUtil.createId(8)),
        ),
    );
    print('updateAt have been updated successfully');
  } catch (e) {
    //print('$e');
  }
}
