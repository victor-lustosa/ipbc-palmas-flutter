import '../../../core/infra/repositories/repository.dart';
import '../../infra/models/lyric_model.dart';
import '../entities/lyric_entity.dart';

abstract class ILyricsUseCases {
  Stream<List<LyricEntity>> get();
  Future<List<LyricEntity>> lettersFilter(List<LyricEntity> lyrics, String letter);
}

class LyricsUseCases implements ILyricsUseCases{
  final IRepository<LyricEntity> repository;
  LyricsUseCases({required this.repository});

  List<LyricEntity> _convert(List<Map> list) {
    return list.map(LyricModel.fromMap).toList();
  }
  @override
  Stream<List<LyricEntity>> get() {
   var lyrics =  repository.get('lyrics');
    return lyrics.map(_convert);
  }
  @override
  Future<List<LyricEntity>> lettersFilter(List<LyricEntity> lyrics, String letter) {
    List<LyricEntity> lyricsResult = [];
    for (LyricEntity lyric in lyrics) {
      if (lyric.title[0].toLowerCase() == letter.toLowerCase()) {
        lyricsResult.add(lyric);
      }
    }
    return Future.value(lyricsResult);
  }
}
