import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../firestore_datasource.dart';
import '../../../shared/components/utils/service_util.dart';
import '../../../lyric/infra/models/firestore-dtos/lyric_dto.dart';
import '../../../lyric/infra/models/firestore-dtos/service_dto.dart';
import '../../../lyric/infra/models/firestore-dtos/settings_dto.dart';
import '../../../lyric/infra/adapters/firestore-dtos/lyric_dto_adapter.dart';
import '../../../lyric/infra/adapters/firestore-dtos/settings_dto_adapter.dart';
import '../../../lyric/infra/adapters/firestore-dtos/collection_dto_adapter.dart';
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

dateNowDelayed() async {
  return Future.delayed(const Duration(seconds: 2), () => DateTime.now());
}

void main() async {
  await firebaseInitialize();
  FirestoreDatasource fire = FirestoreDatasource(firestore: FirebaseFirestore.instance);
  List<LyricDTO> lyricsInserted = [];
  try {
    //servicesListInserts(fire);
    /* List<LyricDTO> saturdayLyrics = await saturdayEveningInserts(fire, 'assets/data/saturday-services/saturday-service-29-04-23.json');
    lyricsInserted.addAll(saturdayLyrics);
    List<LyricDTO> sundayMorningLyrics = await sundayMorningInserts(fire, 'assets/data/sunday-morning-services/sunday-morning-service-14-05-23.json');
    lyricsInserted.addAll(sundayMorningLyrics);*/
    List<LyricDTO> sundayEveningLyrics = await sundayEveningInserts(fire, 'assets/data/sunday-evening-services/sunday-evening-service-14-05-23.json');
    lyricsInserted.addAll(sundayEveningLyrics);
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

Future<List<LyricDTO>> saturdayEveningInserts(FirestoreDatasource fire, String path) async {
  String saturdayServiceUrl = 'saturday-services';
  final String saturdayJson = await rootBundle.loadString(path);
  ServiceDTO result = await ServiceUtil.generateService(
    CollectionDTOAdapter.fromJson(saturdayJson),
  );
  fire.add(saturdayServiceUrl, CollectionDTOAdapter.toMap(result));
  print('Saturday lyrics have been successfully added');
  return result.lyricsList;
}

Future<List<LyricDTO>> sundayMorningInserts(FirestoreDatasource fire, String path) async {
  String sundayMorningServiceUrl = 'sunday-morning-services';
  final String sundayMorningJson = await rootBundle.loadString(path);
  ServiceDTO result = await ServiceUtil.generateService(
    CollectionDTOAdapter.fromJson(sundayMorningJson),
  );
  fire.add(sundayMorningServiceUrl, CollectionDTOAdapter.toMap(result));
  print('Sunday Morning lyrics have been successfully added');
  return result.lyricsList;
}

Future<List<LyricDTO>> sundayEveningInserts(FirestoreDatasource fire, String path) async {
  String sundayEveningServiceUrl = 'sunday-evening-services';
  final String sundayEveningJson = await rootBundle.loadString(path);
  ServiceDTO result = await ServiceUtil.generateService(
    CollectionDTOAdapter.fromJson(sundayEveningJson),
  );
  fire.add(sundayEveningServiceUrl, CollectionDTOAdapter.toMap(result));
  print('Sunday Evening lyrics have been successfully added');
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
  String settingsUrl = 'settings/xgvMavJww017MmVK54A9';
  fire.update(
    settingsUrl,
    SettingsDTOAdapter.toMap(
      SettingsDTO(fireUpdateId: ServiceUtil.createId(8)),
    ),
  );
  print('FireID have been successfully updated');
}
