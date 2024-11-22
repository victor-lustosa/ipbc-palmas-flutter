
import 'package:core_module/core_module.dart';

import '../../../lyric_module.dart';

class LyricsUseCases implements ILyricsUseCases {

  @override
  Future<List<LyricEntity>> lettersFilter(List<LyricEntity> lyrics) {
    List<LyricEntity> lyricsResult = [];
    /*for (LyricEntity lyric in lyrics) {
      if (lyric.title[0].toLowerCase() == letter.toLowerCase()) {
        lyricsResult.add(lyric);
      }
    }*/
    return Future.value(lyricsResult);
  }

}
