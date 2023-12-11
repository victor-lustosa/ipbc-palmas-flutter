import 'dart:math' show Random;

import 'package:flutter/services.dart';
import 'package:uno/uno.dart';

import '../../../core_module.dart';

class SupaServicesUtil {

  static int createId() => int.parse(DateTime.now().microsecondsSinceEpoch.toString());

  static _dateNowDelayed() => Future.delayed(const Duration(seconds: 2), () => DateTime.now());

  static Future<ServiceModel> insertService(String path, List<LyricModel> unknownLyrics) async {
    final String json = await rootBundle.loadString(path);
    ServiceModel service = SupaServiceAdapter.fromJson(json);
    List<LyricEntity> lyricsConverted = await _generateVersesList(service.lyricsList);
    List<LyricModel> lyricsAux = [];
    //aqui vai o codigo para alterar a capa do album
    for (int line = 0; service.lyricsList.length > line; line++) {
      lyricsAux.add(
        service.lyricsList[line].copyWith(
            id: createId(),
            verses: lyricsConverted[line].verses,
            albumCover: lyricsConverted[line].albumCover,
            createAt: await _dateNowDelayed(),
        ),
      );
    }
    lyricsAux.addAll(unknownLyrics);
    return service.copyWith(id: createId(), lyricsList: lyricsAux);
  }

  static Future<List<LyricEntity>> _generateVersesList(List<LyricEntity> lyricsList) async {
    List<LyricEntity> results = [];
    for (int i = 0; lyricsList.length > i; i++) {
      Map result = await _getLyric(lyricsList[i].title, lyricsList[i].group);
      results.add(LyricModel.empty().copyWith(verses: VerseAdapter.fromVagalume(result), albumCover: AppImages.defaultCoversList[Random().nextInt(4)]));
    }
    return results;
  }

  static Future<dynamic> _getLyric(String title, String group) async {
    String titleParam = title.replaceAll(' ', '%20');
    String groupParam = group.replaceAll(' ', '%20');
    String apikey = 'a34faccfb8ad3edc6ddcc978e34802ef';
    try {
      final response = await Uno().get('https://api.vagalume.com.br/search.php?art=$groupParam&mus=$titleParam&apikey=$apikey');
      return response.data;
    } on UnoError catch (error, st) {
      AnalyticsUtil.recordError(name: 'service util', error: error, st: st);
    }
  }

  static Future<LyricModel> convertUnknownLyric(String path) async {
    final String unknownJson = await rootBundle.loadString(path);
    LyricModel unknownLyric = SupaLyricAdapter.fromUnknownJson(unknownJson);
    return unknownLyric.copyWith(id: SupaServicesUtil.createId(), albumCover: AppImages.defaultCoversList[Random().nextInt(4)]);
  }

  static Future<List<Map<String, dynamic>>> servicesListFilled() async {
    List<Map<String, dynamic>> servicesList = [
      {
        'id': createId(),
        'title': 'Domingo à noite',
        'heading': 'domingo à noite',
        'createAt': await _dateNowDelayed(),
        'image': 'https://xrvmfhpmelyvupfylnfk.supabase.co/storage/v1/object/public/covers/web_service_covers/sunday_evening_service_sm.png',
        'path': 'sunday-evening-services/20',
        'hour': '19h'
      },
      {
        'id': createId(),
        'title': 'Domingo pela manhã',
        'heading': 'domingo pela manhã',
        'createAt': await _dateNowDelayed(),
        'image': 'https://xrvmfhpmelyvupfylnfk.supabase.co/storage/v1/object/public/covers/web_service_covers/sunday_morning_service_sm.png',
        'path': 'sunday-morning-services/20',
        'hour': '9h'
      },
      {
        'id': createId(),
        'title': 'Sábado à noite',
        'createAt': await _dateNowDelayed(),
        'heading': 'sábado à noite (UMP)',
        'image': 'https://xrvmfhpmelyvupfylnfk.supabase.co/storage/v1/object/public/covers/web_service_covers/saturday_service_sm.png',
        'path': 'saturday-services/20',
        'hour': '19h30'
      },
    ];
    return servicesList;
  }
}
