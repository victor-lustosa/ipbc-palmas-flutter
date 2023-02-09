import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ipbc_palmas/app/lyric/infra/adapters/lyric_adapter.dart';

import '../../../firebase_options.dart';
import '../../lyric/infra/models/lyric_model.dart';

class FirebaseInserts {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late List<String> params;

  Future<void> add(String url, data) async {
    params = url.split('/');

    if (params.length > 1) {
      _firestore
          .collection(params[0])
          .doc(params[1])
          .collection(params[2])
          .doc(params[3])
          .set(LyricAdapter.toMap(data));
    } else {
      _firestore
          .collection(params[0])
          .doc(params[1])
          .set(LyricAdapter.toMap(data));
    }
  }
}

void main() async {

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (details) {
    log(
      details.exceptionAsString(),
      stackTrace: details.stack,
    );
  };

  FirebaseInserts fire = FirebaseInserts();
  WidgetsFlutterBinding.ensureInitialized();
  String url = '';
  final String response =
  await rootBundle.loadString('assets/data/lyrics.json');

  List<LyricModel> lyrics = LyricAdapter.listFromJson(response);
  final results = lyrics.map((entity) => entity.copyWith(createAt: Timestamp.now().toDate().toString()));
  //print(results.toString());
  for(LyricModel lyric in results){
    fire.add(url,lyric);
  }

  /*LyricEntity lyricEntity = LyricEntity(
      albumCover:
          'http://coverartarchive.org/release/ce82afc5-f866-400e-adcd-4a23c01dd877/4433492734-500.jpg',
      id: '0',
      title: 'agua viva',
      createAt: timestamp.toString(),
      group: 'oficina g3',
      verses: [
        VerseEntity(id: 0, isChorus: false, versesList:
          'Vejo em Seu rosto uma luz',
          'E o convido a ficar',
          'Sua voz me constrange'/*LyricEntity lyricEntity = LyricEntity(
      albumCover:
          'http://coverartarchive.org/release/ce82afc5-f866-400e-adcd-4a23c01dd877/4433492734-500.jpg',
      id: '0',
      title: 'agua viva',
      createAt: timestamp.toString(),
      group: 'oficina g3',
      verses: [
        VerseEntity(id: 0, isChorus: false, versesList:
          'Vejo em Seu rosto uma luz',
          'E o convido a ficar',
          'Sua voz me constrange',
          'Anseio escutar'
        ])
      ]);
  final result = LyricAdapter.toMap(lyricEntity);
  print(result.toString());*/


  //LyricEntity lyricEntity = LyricEntity(
     final String response =
      await rootBundle.loadString('assets/data/lyrics.json');,
          'Anseio escutar'
        ])
      ]);
  final result = LyricAdapter.toMap(lyricEntity);
  print(result.toString());*/


  //Stream<List<int>> stream = File('lyrics.json').openRead();
 // StringBuffer buffer = StringBuffer();
 // stream.transform(utf8.decoder).listen((data) {
 //   buffer.write(data);
 // }, onDone: () => print(buffer.toString()), onError: (e) => print(e));
}
