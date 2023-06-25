import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core_module.dart';
import '../../../lyric/infra/models/lyric_model.dart';
import '../../../lyric/infra/models/service_model.dart';
import '../../../lyric/infra/models/firestore-dtos/settings_dto.dart';
import '../../../lyric/infra/adapters/firestore-dtos/settings_dto_adapter.dart';
import '../../../shared/utils/service_util.dart';

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
  FirestoreDatasource fire = FirestoreDatasource(firestore: FirebaseFirestore.instance);
  List<LyricModel> lyricsInserted = [];
  List<LyricModel> unknownLyrics = [];
  try {
      //servicesListInserts(fire);
    //  LyricModel lyric0 = await convertUnknownLyric(fire, 'assets/data/unknown-lyrics/hino-13.json');
    LyricModel lyric0 = await ServiceUtil.convertUnknownLyric(fire, 'assets/data/unknown-lyrics/hino-4.json');
    //LyricModel lyric1 = await ServiceUtil.convertUnknownLyric(fire, 'assets/data/unknown-lyrics/hino-395.json');
    //LyricModel lyric2 = await convertUnknownLyric(fire, 'assets/data/unknown-lyrics/salmo-27.json');

    unknownLyrics.addAll([lyric0]);
    /* List<LyricModel> saturdayLyrics = await insertService(
        'assets/data/saturday-services/saturday-service-29-04-23.json',
        'saturday-services',
        fire,
        unknownLyrics);
    print('Saturday lyrics have been successfully added');
    lyricsInserted.addAll(saturdayLyrics);
*/
    /* List<LyricModel> sundayEveningLyrics = await insertService(
      'assets/data/sunday-evening-services/sunday-evening-service-11-06-23.json',
      'sunday-evening-services',
      fire,
      unknownLyrics,
    );
    print('Sunday Evening lyrics have been successfully added');
    lyricsInserted.addAll(sundayEveningLyrics);
*/
    List<LyricModel> sundayMorningLyrics = await insertService(
        'assets/data/sunday-morning-services/sunday-morning-service-18-06-23.json',
        'sunday-morning-services',
        fire,
        unknownLyrics,
    );

    print('Sunday Morning lyrics have been successfully added');
    lyricsInserted.addAll(sundayMorningLyrics);

    ServiceUtil.unknownLyricsInsert(fire, unknownLyrics);

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
      'createAt': await ServiceUtil.dateNowDelayed(),
      'image': 'assets/images/sunday_evening.png',
      'path': 'sunday-evening-services/20',
      'hour': '19h'
    },
    {
      'id': ServiceUtil.createId(8),
      'title': 'Domingo pela manhã',
      'heading': 'domingo pela manhã',
      'createAt': await ServiceUtil.dateNowDelayed(),
      'image': 'assets/images/sunday_morning.jpg',
      'path': 'sunday-morning-services/20',
      'hour': '9h'
    },
    {
      'id': ServiceUtil.createId(8),
      'title': 'Sábado à noite',
      'createAt': await ServiceUtil.dateNowDelayed(),
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

Future<List<LyricModel>> insertService(String path, String url,
    FirestoreDatasource fire, List<LyricModel> unknownLyrics) async {
  final String json = await rootBundle.loadString(path);
  ServiceModel result = await ServiceUtil.generateService(
    ServiceAdapter.fromJson(json),
    unknownLyrics,
  );
  fire.add(url, ServiceAdapter.toMap(result));
  return result.lyricsList;
}

lyricsInserts(FirestoreDatasource fire, List<LyricEntity> lyricsInserted) async {
  String lyricsUrl = 'lyrics';
  for (LyricEntity lyric in lyricsInserted) {
    fire.add(lyricsUrl, LyricAdapter.toMap(lyric));
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