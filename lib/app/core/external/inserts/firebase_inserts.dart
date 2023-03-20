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
  VersesUtil verseUtil = VersesUtil();
  String lyricsUrl = 'lyrics';
  String servicesUrl = 'services/rAQy5wpQEFTdSz3Ah0SY';

  final String saturdayResponse = await rootBundle.loadString('assets/data/saturday-lyrics.json');
  final String sundayEveningResponse = await rootBundle.loadString('assets/data/sunday-evening-lyrics.json');
  //final String sundayMorningResponse = await rootBundle.loadString('assets/data/sunday-morning-lyrics.json');

  List<ServiceDTO> services = [];
  List<ServiceDTO> servicesAux = [];
  List<LyricDTO> lyricsAux = [];
  services.add(ServiceDTOAdapter.fromJson(saturdayResponse));
  services.add(ServiceDTOAdapter.fromJson(sundayEveningResponse));
  //services.add(ServiceDTOAdapter.fromJson(sundayMorningResponse));

  for (int column = 0; services.length > column; column++) {
    List<LyricDTO> lyricsConverted = await verseUtil.generateVersesList(services[column].lyricsList);
    //aqui vai o codigo para alterar a capa do album
    for (int line = 0; services[column].lyricsList.length > line; line++) {
      lyricsAux.add(
        services[column].lyricsList[line].copyWith(
          id: lyricsConverted[line].id,
          verses: lyricsConverted[line].verses,
          albumCover: lyricsConverted[line].albumCover,
        ),
      );
    }

    servicesAux.add(
      services[column].copyWith(lyricsList: lyricsAux),
    );
  }

  for (LyricDTO lyric in lyricsAux) {
    fire.add(
      lyricsUrl,
      LyricDTOAdapter.toMap(lyric),
    );
  }

  print('total de musicas inseridas: ${lyricsAux.length}');

  fire.update(
    servicesUrl,
    ServiceDTOAdapter.toMapList(servicesAux),
  );
}
