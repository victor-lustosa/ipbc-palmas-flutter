import 'dart:math' show Random;

import 'package:flutter/services.dart';
import 'package:uno/uno.dart';

import '../../../core_module.dart';

class SupaServiceUtil {
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _random = Random();
  static final AnalyticsUtil analyticsUtil = AnalyticsUtil();

  static String createId(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_random.nextInt(_chars.length))));

  static dateNowDelayed() => Future.delayed(const Duration(seconds: 2), () => DateTime.now());

  static Future<ServiceModel> insertService(String path, List<LyricModel> unknownLyrics) async {
    final String json = await rootBundle.loadString(path);
    ServiceModel service = SupaServiceAdapter.fromJson(json);
    List<LyricEntity> lyricsConverted = await generateVersesList(service.lyricsList);
    List<LyricModel> lyricsAux = [];
    //aqui vai o codigo para alterar a capa do album
    for (int line = 0; service.lyricsList.length > line; line++) {
      lyricsAux.add(
        service.lyricsList[line].copyWith(
            id: createId(8),
            verses: lyricsConverted[line].verses,
            albumCover: lyricsConverted[line].albumCover,
            createAt: await dateNowDelayed(),
        ),
      );
    }
    lyricsAux.addAll(unknownLyrics);
    return service.copyWith(id: createId(8), lyricsList: lyricsAux);
  }

  static Future<List<LyricEntity>> generateVersesList(List<LyricEntity> lyricsList) async {
    List<LyricEntity> results = [];
    for (int i = 0; lyricsList.length > i; i++) {
      Map result = await getLyric(lyricsList[i].title, lyricsList[i].group);
      results.add(
        LyricModel.empty().copyWith(
          verses: VerseAdapter.fromVagalume(result),
          albumCover: AppImages.defaultCoversList[Random().nextInt(4)],
        ),
      );
    }
    return results;
  }

  static Future<dynamic> getLyric(String title, String group) async {
    String titleParam = title.replaceAll(' ', '%20');
    String groupParam = group.replaceAll(' ', '%20');
    String apikey = 'a34faccfb8ad3edc6ddcc978e34802ef';
    try {
      final response = await Uno().get('https://api.vagalume.com.br/search.php?art=$groupParam&mus=$titleParam&apikey=$apikey');
      return response.data;
    } on UnoError catch (error, st) {
      analyticsUtil.recordError(name: 'service util', error: error, st: st);
    }
  }

  static Future<LyricModel> convertUnknownLyric(String path) async {
    final String unknownJson = await rootBundle.loadString(path);
    LyricModel unknownLyric = SupaLyricAdapter.fromUnknownJson(unknownJson);
    return unknownLyric.copyWith(
      id: SupaServiceUtil.createId(8),
      albumCover: AppImages.defaultCoversList[Random().nextInt(4)],
    );
  }

  static Future<List<Map<String, dynamic>>> insertServicesList() async {
    List<Map<String, dynamic>> servicesList = [
      {
        'id': SupaServiceUtil.createId(8),
        'title': 'Domingo à noite',
        'heading': 'domingo à noite',
        'createAt': await SupaServiceUtil.dateNowDelayed(),
        'image': 'assets/images/sunday_evening.png',
        'path': 'sunday-evening-services/20',
        'hour': '19h'
      },
      {
        'id': SupaServiceUtil.createId(8),
        'title': 'Domingo pela manhã',
        'heading': 'domingo pela manhã',
        'createAt': await SupaServiceUtil.dateNowDelayed(),
        'image': 'assets/images/sunday_morning.jpg',
        'path': 'sunday-morning-services/20',
        'hour': '9h'
      },
      {
        'id': SupaServiceUtil.createId(8),
        'title': 'Sábado à noite',
        'createAt': await SupaServiceUtil.dateNowDelayed(),
        'heading': 'sábado à noite (UMP)',
        'image': 'assets/images/saturday_evening.png',
        'path': 'saturday-services/20',
        'hour': '19h30'
      },
    ];

    /*  for (Map service in servicesList) {
      supa.add('services', service);
    }
    print('Services list have been successfully added');*/
    return servicesList;
  }
}
