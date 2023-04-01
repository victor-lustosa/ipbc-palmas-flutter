import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../lyric/infra/adapters/firestore-dtos/lyric_dto_adapter.dart';
import '../../../lyric/infra/adapters/firestore-dtos/service_dto_adapter.dart';
import '../../../../firebase_options.dart';
import '../../../lyric/infra/models/firestore-dtos/lyric_dto.dart';
import '../../../lyric/infra/models/firestore-dtos/service_dto.dart';
import '../../../shared/components/utils/verses_util.dart';
import '../firestore_datasource.dart';

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

Future<DateTime> dateNow() async {
  return Future.delayed(
    const Duration(seconds: 2),
    () => Timestamp.now().toDate(),
  );
}

void main() async {

  await firebaseInitialize();

  FirestoreDatasource fire = FirestoreDatasource(firestore: FirebaseFirestore.instance);

  String lyricsUrl = 'lyrics';
  String saturdayServiceUrl = 'saturday-services';
  String morningSundayServiceUrl = 'morning-sunday-services';
  String eveningSundayServiceUrl = 'evening-sunday-services';

  try {

    final String saturdayJson = await rootBundle.loadString('assets/data/saturday-service.json');
    final String sundayEveningJson = await rootBundle.loadString('assets/data/sunday-evening-service.json');
    //final String sundayMorningJson = await rootBundle.loadString('assets/data/sunday-morning-service.json');

    List<ServiceDTO> services = [];
    List<ServiceDTO> servicesAux = [];
    List<LyricDTO> lyricsAux = [];
    List<LyricDTO> allLyricsInserted = [];
    services.add(ServiceDTOAdapter.fromJson(saturdayJson));
    services.add(ServiceDTOAdapter.fromJson(sundayEveningJson));
    //services.add(ServiceDTOAdapter.fromJson(sundayMorningJson));

    for (ServiceDTO service in services) {
      List<LyricDTO> lyricsConverted = await VersesUtil.generateVersesList(service.lyricsList);
      lyricsAux = [];
      //aqui vai o codigo para alterar a capa do album
      for (int i = 0; service.lyricsList.length > i; i++) {
        lyricsAux.add(
          service.lyricsList[i].copyWith(
            id: lyricsConverted[i].id,
            verses: lyricsConverted[i].verses,
            albumCover: lyricsConverted[i].albumCover,
          ),
        );
      }
      allLyricsInserted.addAll(lyricsAux);
      servicesAux.add(service.copyWith(lyricsList: lyricsAux));
    }

    for (LyricDTO lyric in allLyricsInserted) {
    fire.add(lyricsUrl, LyricDTOAdapter.toMap(lyric));
    }

    print('Total number of lyrics inserted: ${allLyricsInserted.length}');

    fire.add(saturdayServiceUrl, ServiceDTOAdapter.toMap(servicesAux[0]));
    fire.add(morningSundayServiceUrl, ServiceDTOAdapter.toMap(servicesAux[1]));

    print('Services and lyrics have been added successfully');

  }catch(e){
    print('$e');
  }
}
