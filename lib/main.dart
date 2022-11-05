import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ipbc_palmas/bootstrap.dart';
import 'app/lyric/external/datasource/lyric_firestore_datasource.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final lyricDatasource =
      LyricFirestoreDatasource(firestore: FirebaseFirestore.instance);
  bootstrap(lyricDatasource: lyricDatasource);
}
