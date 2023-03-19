import '../../../core/domain/repositories/repository.dart';
import '../../domain/entities/lyric_entity.dart';
import '../../domain/use-cases/lyrics_use_cases.dart';
import '../adapters/lyric_adapter.dart';

class LyricsUseCases implements ILyricsUseCases<LyricEntity, Stream<List<LyricEntity>>> {
  final IRepository<Stream<List<Map<dynamic, dynamic>>>> repository;
  LyricsUseCases({required this.repository});

  List<LyricEntity> _convert(List<Map<dynamic, dynamic>> list) {
    return list.map(LyricAdapter.fromMap).toList();
  }

  @override
  Stream<List<LyricEntity>> get(String url) {
    var lyrics = repository.get(url);
    return lyrics!.map(_convert);
  }

  @override
  Future<List<LyricEntity>> lettersFilter(
      List<LyricEntity> lyrics, String letter) {
    List<LyricEntity> lyricsResult = [];
    for (LyricEntity lyric in lyrics) {
      if (lyric.title[0].toLowerCase() == letter.toLowerCase()) {
        lyricsResult.add(lyric);
      }
    }
    return Future.value(lyricsResult);
  }


}