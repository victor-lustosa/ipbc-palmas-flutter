/*import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../../core_module.dart';
import '../../../shared/utils/fire_service_util.dart';

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
    List<LyricModel> sundayMorningLyrics = await ServiceUtil.insertService(
        'assets/data/sunday-morning-services/sunday-morning-service-18-06-23.json',
        'sunday-morning-services',
        fire,
        unknownLyrics,
    );
    lyricsInserted.addAll(sundayMorningLyrics);
    ServiceUtil.unknownLyricsInsert(fire, unknownLyrics);
    ServiceUtil.insertLyrics(fire, lyricsInserted);
    ServiceUtil.updateFireID(fire);
  } catch (e) {
    print('$e');
  }
}*/