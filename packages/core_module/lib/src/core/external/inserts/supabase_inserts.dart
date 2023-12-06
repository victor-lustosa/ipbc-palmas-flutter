import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core_module.dart';
import '../../../shared/utils/supa_service_util.dart';

// ignore_for_file: avoid_print

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SupabaseDatasource.init();

  SupabaseDatasource supa = SupabaseDatasource(supabaseClient: Supabase.instance.client);

  List<LyricModel> lyricsInserted = [];
  List<LyricModel> unknownLyrics = [];
  const String saturdayPath = 'assets/data/saturday-services/saturday-service-29-04-23.json';
  const String sundayMorningPath = 'assets/data/sunday-morning-services/sunday-morning-service-18-06-23.json';
  const String sundayEveningPath = 'assets/data/sunday-evening-services/sunday-evening-service-11-06-23.json';
  try {
    LyricModel lyric0 = await SupaServiceUtil.convertUnknownLyric('assets/data/unknown-lyrics/hino-4.json');
    LyricModel lyric1 = await SupaServiceUtil.convertUnknownLyric('assets/data/unknown-lyrics/hino-395.json');

    unknownLyrics.addAll([lyric0]);

    ServiceModel saturdayService = await SupaServiceUtil.insertService(saturdayPath, unknownLyrics);
    supa.add('saturday-services', SupaServiceAdapter.toMap(saturdayService));
    print('Saturday lyrics have been successfully added');
    lyricsInserted.addAll(saturdayService.lyricsList);

    ServiceModel sundayEveningService = await SupaServiceUtil.insertService(sundayEveningPath, unknownLyrics);
    supa.add('sunday-evening-services', SupaServiceAdapter.toMap(sundayEveningService));
    print('Sunday Evening lyrics have been successfully added');
    lyricsInserted.addAll(sundayEveningService.lyricsList);

    ServiceModel sundayMorningService = await SupaServiceUtil.insertService(sundayMorningPath, unknownLyrics);
    supa.add('sunday-morning-services', SupaServiceAdapter.toMap(sundayMorningService));
    print('Sunday Evening lyrics have been successfully added');
    lyricsInserted.addAll(sundayMorningService.lyricsList);

    // inserindo lista de letras desconhecidas
    if (unknownLyrics.isNotEmpty) {
      for (LyricModel entity in unknownLyrics) {
        supa.add('unknown-lyrics', SupaLyricAdapter.toMap(entity));
      }
    }
    print('Unknown lyrics have been successfully added');

    // inserindo lista de todas as letras

    for (LyricEntity lyric in lyricsInserted) {
      supa.add('lyrics', SupaLyricAdapter.toMap(lyric));
    }
    print('lyrics list have been successfully added');
    print('Total number of lyrics inserted: ${lyricsInserted.length}');

  } catch (e) {
    print('$e');
  }
}
