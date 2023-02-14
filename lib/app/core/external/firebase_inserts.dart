import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../lyric/infra/adapters/dtos/service_dto_adapter.dart';
import '../../../firebase_options.dart';
import '../../lyric/infra/models/dtos/service_dto.dart';
import 'firestore_datasource.dart';

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

  String lyricsUrl = 'lyrics';
  String servicesUrl = 'services/XTfqjbcVEwSgSy2WqNnU';
  final String saturdayResponse = await rootBundle.loadString('assets/data/saturday-lyrics.json');
  final String sundayEveningResponse = await rootBundle.loadString('assets/data/sunday-evening-lyrics.json');
  final String sundayMorningResponse = await rootBundle.loadString('assets/data/sunday-morning-lyrics.json');

  List<ServiceDTO> services = [];

  services.add(ServiceDTOAdapter.fromJson(saturdayResponse));
  services.add(ServiceDTOAdapter.fromJson(sundayEveningResponse));
  services.add(ServiceDTOAdapter.fromJson(sundayMorningResponse));
 // print(services.toString());
  //List<LyricDTO> lyrics = services[0].lyricsList;
  //lyrics.map((lyric) => fire.add(lyricsUrl,LyricDTOAdapter.toMap(lyric)));
  fire.update(servicesUrl, ServiceDTOAdapter.toMapList(services));

}
