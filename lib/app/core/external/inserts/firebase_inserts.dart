import 'dart:developer';
import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../firestore_datasource.dart';
import '../../../configs/app_configs.dart';
import '../../../../firebase_options.dart';
import '../../../shared/components/utils/service_util.dart';
import '../../../lyric/infra/models/firestore-dtos/lyric_dto.dart';
import '../../../lyric/infra/models/firestore-dtos/service_dto.dart';
import '../../../lyric/infra/models/firestore-dtos/settings_dto.dart';
import '../../../lyric/infra/adapters/firestore-dtos/lyric_dto_adapter.dart';
import '../../../lyric/infra/adapters/firestore-dtos/settings_dto_adapter.dart';
import '../../../lyric/infra/adapters/firestore-dtos/collection_dto_adapter.dart';

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

dateNowDelayed() async {
  return Future.delayed(const Duration(seconds: 2), () => DateTime.now());
}

void main() async {
  await firebaseInitialize();
  FirestoreDatasource fire = FirestoreDatasource(firestore: FirebaseFirestore.instance);
  List<LyricDTO> lyricsInserted = [];
  try {
    //servicesListInserts(fire);
    //LyricDTO lyric0 = await convertUnknownLyric(fire, 'assets/data/unknown-lyrics/hino-351.json');
    //LyricDTO lyric1 = await convertUnknownLyric(fire, 'assets/data/unknown-lyrics/hino-108.json');
    //LyricDTO lyric2 = await convertUnknownLyric(fire, 'assets/data/unknown-lyrics/vivifica-me.json');
    //List<LyricDTO> lyricsAux = await unknownLyricsInsert(fire, [lyric0]);
    /*List<LyricDTO> saturdayLyrics = await insertService('assets/data/saturday-services/saturday-service-29-04-23.json', 'saturday-services', fire, lyricsAux);
    print('Saturday lyrics have been successfully added');
    lyricsInserted.addAll(saturdayLyrics);

   List<LyricDTO> sundayEveningLyrics = await insertService(
        'assets/data/sunday-evening-services/sunday-evening-service-21-05-23.json',
        'sunday-evening-services',
        fire,
        lyricsAux,
    );
      print('Sunday Evening lyrics have been successfully added');
      lyricsInserted.addAll(sundayEveningLyrics);
    */
    List<LyricDTO> sundayMorningLyrics = await insertService(
        'assets/data/sunday-morning-services/sunday-morning-service-21-05-23.json',
        'sunday-morning-services',
        fire,
        [],
    );

    print('Sunday Morning lyrics have been successfully added');
    lyricsInserted.addAll(sundayMorningLyrics);

    lyricsInserts(fire, lyricsInserted);
    updateFireID(fire);
  } catch (e) {
    print('$e');
  }
}

servicesListInserts(FirestoreDatasource fire) async {
  String servicesUrl = 'services';
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

  for (Map service in services) {
    fire.add(servicesUrl, service);
  }
  print('Services list have been successfully added');
}

Future<LyricDTO> convertUnknownLyric(FirestoreDatasource fire, String path) async {
  final String unknownJson = await rootBundle.loadString(path);
  return LyricDTOAdapter.fromUnknownJson(unknownJson);
}

Future<List<LyricDTO>> unknownLyricsInsert(FirestoreDatasource fire, List<LyricDTO> lyricsInserted) async {
  List<LyricDTO> lyricsAux = [];
  if (lyricsInserted.isNotEmpty) {
    for (LyricDTO entity in lyricsInserted) {
      lyricsAux.add(
        entity.copyWith(
          id: ServiceUtil.createId(8),
          albumCover: AppImages.defaultCoversList[Random().nextInt(4)],
        ),
      );
    }
  }
  for (LyricDTO entity in lyricsAux) {
    fire.add('unknown-lyrics', LyricDTOAdapter.toMap(entity));
  }
  print('Unknown lyrics have been successfully added');
  return lyricsAux;
}

Future<List<LyricDTO>> insertService(String path, String url, FirestoreDatasource fire, List<LyricDTO> unknownLyrics) async {
  final String json = await rootBundle.loadString(path);
  ServiceDTO result = await ServiceUtil.generateService(
      CollectionDTOAdapter.fromJson(json),
      unknownLyrics,
  );
  fire.add(url, CollectionDTOAdapter.toMap(result));
  return result.lyricsList;
}

lyricsInserts(FirestoreDatasource fire, List<LyricDTO> lyricsInserted) async {
  String lyricsUrl = 'lyrics';
  for (LyricDTO lyric in lyricsInserted) {
    fire.add(lyricsUrl, LyricDTOAdapter.toMap(lyric));
  }
  print('lyrics list have been successfully added');
  print('Total number of lyrics inserted: ${lyricsInserted.length}');
}

updateFireID(FirestoreDatasource fire) async {
  String settingsUrl = 'settings/LTwnciNO0YmWAmf7GHcU';
  fire.update(
    settingsUrl,
    SettingsDTOAdapter.toMap(
      SettingsDTO(fireId: ServiceUtil.createId(8)),
    ),
  );
  print('FireID have been successfully updated');
}
