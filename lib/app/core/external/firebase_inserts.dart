import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../lyric/infra/adapters/dtos/service_dto_adapter.dart';
import '../../../firebase_options.dart';
import '../../lyric/infra/models/dtos/lyric_dto.dart';
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

/*** SABADO ***/
/*Future<void> main() async {

  await firebaseInitialize();
  FirebaseInserts fire = FirebaseInserts();

  String lyricsUrl = 'lyrics';
  String saturdayUrl = 'weekend-lyrics/UskDQoSEFcZMljOtf7ab/saturday-evening';
  final String saturdayResponse = await rootBundle.loadString('assets/data/saturday-lyrics.json');
  List<InsertDTO> saturdayLyrics = InsertDTO.fromJson(saturdayResponse);

}*/
/**** DOMINGO DE MANHA ****/
/*void main() async {

  firebaseInitialize();
  FirebaseInserts fire = FirebaseInserts();
  String sundayMorningUrl = 'weekend-lyrics/lbDmsvEuUmo92fYN9sXR/sunday-morning';
  final String sundayMorningResponse = await rootBundle.loadString('assets/data/sunday-morning-lyrics.json');
  List<LyricModel> sundayMorningLyrics = LyricAdapter.listFromJson(sundayMorningResponse);

}*/

/**** DOMINGO DE NOITE ****/
void main() async {

  await firebaseInitialize();
  FirestoreDatasource fire = FirestoreDatasource(firestore: FirebaseFirestore.instance);

  String lyricsUrl = 'lyrics';
  String sundayEveningUrl = 'services/vthPis6Awr1bNrsZl8KL/sunday-evening';

  final String sundayEveningResponse = await rootBundle.loadString('assets/data/sunday-evening-lyrics.json');

  ServiceDTO sundayEveningService = ServiceDTOAdapter.fromJson(sundayEveningResponse);
  List<LyricDTO> lyrics = sundayEveningService.lyricsList;
  //lyrics.map((lyric) => fire.add(lyricsUrl,LyricDTOAdapter.toMap(lyric)));
  fire.add(sundayEveningUrl, ServiceDTOAdapter.toMap(sundayEveningService));
}
