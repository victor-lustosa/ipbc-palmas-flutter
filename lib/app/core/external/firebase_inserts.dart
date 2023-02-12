import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ipbc_palmas/app/lyric/infra/adapters/dtos/lyric_dto_adapter.dart';
import 'package:path_provider/path_provider.dart';

import '../../lyric/infra/adapters/dtos/service_dto_adapter.dart';
import '../../../firebase_options.dart';
import '../../lyric/infra/models/dtos/lyric_dto.dart';
import '../../lyric/infra/models/dtos/service_dto.dart';

class FirebaseInserts {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late List<String> params;

  Future<void> add(String url, data) async {
    params = url.split('/');
    if (data is ServiceDTO) {
      if (params.length > 1) {
        _firestore
            .collection(params[0])
            .doc(params[1])
            .collection(params[2])
            .add(ServiceDTOAdapter.toMap(data));
      } else {
        _firestore.collection(params[0]).add(ServiceDTOAdapter.toMap(data));
      }
    } else if (data is List<LyricDTO>) {
      if (params.length > 1) {
        data.map((entity) => _firestore
            .collection(params[0])
            .doc(params[1])
            .collection(params[2])
            .add(LyricDTOAdapter.toMap(entity)));
      }
    } else {
      data.map((entity) =>
          _firestore.collection(params[0]).add(LyricDTOAdapter.toMap(data)));
    }
  }
}

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

  for(InsertDTO lyric in saturdayLyrics){
    DateTime createAt = await timeNow();
    InsertDTO entity = lyric.copyWith(createAt: createAt);
    //fire.add(lyricsUrl,entity);
    //fire.add(saturdayUrl,entity);
  }
}*/
/**** DOMINGO DE MANHA ****/
/*void main() async {

  firebaseInitialize();

  FirebaseInserts fire = FirebaseInserts();

  String sundayMorningUrl = 'weekend-lyrics/lbDmsvEuUmo92fYN9sXR/sunday-morning';

  final String sundayMorningResponse =
  await rootBundle.loadString('assets/data/sunday-morning-lyrics.json');

  List<LyricModel> sundayMorningLyrics = LyricAdapter.listFromJson(sundayMorningResponse);

  final sundayMorningResults = sundayMorningLyrics.map((entity) => entity.copyWith(createAt: Timestamp.now().toDate().toString()));
  //print(results.toString());
  for(LyricModel lyric in sundayMorningResults){
    fire.add(sundayMorningUrl,lyric);
  }
}*/

/**** DOMINGO DE NOITE ****/
void main() async {
  await firebaseInitialize();

  FirebaseInserts fire = FirebaseInserts();

  String lyricsUrl = 'lyrics';
  String sundayEveningUrl =
      'services/vthPis6Awr1bNrsZl8KL/sunday-evening';

  final String sundayEveningResponse =
      await rootBundle.loadString('assets/data/sunday-evening-lyrics.json');

  ServiceDTO sundayEveningService =
      ServiceDTOAdapter.fromJson(sundayEveningResponse);
  List<LyricDTO> lyrics = sundayEveningService.lyricsList;
  //print(sundayEveningService.toString());

// final Directory directory = await getApplicationDocumentsDirectory();
  //final File file = File(' ${directory.path}/assets/data/my_file.txt');
  //await file.writeAsString(sundayEveningService.toString());
  //print(entity);
  // fire.add(lyricsUrl,lyrics);
  fire.add(sundayEveningUrl, sundayEveningService);
}
