import 'dart:math';
import 'package:uno/uno.dart';

import '../../../configs/app_configs.dart';
import '../../../lyric/infra/models/lyric_model.dart';
import '../../../lyric/infra/models/service_model.dart';
import '../../../lyric/domain/entities/lyric_entity.dart';
import '../../../lyric/infra/adapters/verse_adapter.dart';
import '../../../shared/components/utils/analytics_util.dart';

class ServiceUtil {
  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _random = Random();
  static final AnalyticsUtil analyticsUtil = AnalyticsUtil();

  static String createId(int length) {
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(_random.nextInt(_chars.length)),
      ),
    );
  }

  static generateService(ServiceModel service, List<LyricModel> unknownLyrics) async {
    List<LyricEntity> lyricsConverted = await generateVersesList(service.lyricsList);
    List<LyricModel> lyricsAux = [];
    //aqui vai o codigo para alterar a capa do album
    for (int line = 0; service.lyricsList.length > line; line++) {
      lyricsAux.add(
        service.lyricsList[line].copyWith(
          id: createId(8),
          verses: lyricsConverted[line].verses,
          albumCover: lyricsConverted[line].albumCover,
        ),
      );
    }
    lyricsAux.addAll(unknownLyrics);
    return service.copyWith(
      id: createId(8),
      lyricsList: lyricsAux,
    );
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
      final response = await Uno().get(
        'https://api.vagalume.com.br/search.php?art=$groupParam&mus=$titleParam&apikey=$apikey',
      );
      return response.data;
    } on UnoError catch (error, st) {
      analyticsUtil.recordError(name:'service util', error:error,st: st);
    }
  }
}
