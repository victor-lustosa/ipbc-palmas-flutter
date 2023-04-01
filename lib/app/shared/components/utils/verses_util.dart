
import '../../../lyric/infra/adapters/firestore-dtos/verse_dto_adapter.dart';
import '../../../lyric/infra/models/firestore-dtos/lyric_dto.dart';
import '../../configs/app_configs.dart';

import 'dart:math';
import 'package:uno/uno.dart';

class VersesUtil {

  static Future<dynamic> getLyric(String title, String group) async {
    String titleParam = title.replaceAll(' ', '%20');
    String groupParam = group.replaceAll(' ', '%20');
    String apikey = 'a34faccfb8ad3edc6ddcc978e34802ef';
    try {
      final response = await Uno().get('https://api.vagalume.com.br/search.php?art=$groupParam&mus=$titleParam&apikey=$apikey');
      return response.data;
    } on UnoError catch (error) {
      print(error);
    }
  }

  static Future<List<LyricDTO>> generateVersesList(List<LyricDTO> lyricsList) async {
    List<LyricDTO> results = [];
    for (int i = 0; lyricsList.length > i; i++) {
      Map result = await getLyric(lyricsList[i].title, lyricsList[i].group);
      results.add(
        LyricDTO(
          verses: VerseDTOAdapter.fromVagalume(result),
          albumCover: AppImages.defaultCoversList[Random().nextInt(4)],
          id: '$i',
          title: '',
          createAt: DateTime.now(),
          group: '',
        ),
      );
    }
    return results;
  }
}

