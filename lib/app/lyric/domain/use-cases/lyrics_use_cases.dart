
import '../entities/lyric_entity.dart';

abstract class ILyricsUseCases {
  Stream<List<LyricEntity>> get(String url);
  Future<List<LyricEntity>> lettersFilter(
      List<LyricEntity> lyrics, String letter);
}


