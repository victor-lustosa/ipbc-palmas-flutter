import '../adapters/lyric_adapter.dart';
import '../../domain/entities/lyric_entity.dart';
import '../../domain/use-cases/lyrics_use_cases.dart';
import '../../../core/domain/repositories/repository.dart';

class LyricsUseCases implements ILyricsUseCases<Stream<List<LyricEntity>>> {
  final IRepository<Stream<List<Map>>> repository;

  LyricsUseCases({required this.repository});

  @override
  Future<Stream<List<LyricEntity>>> get(String url) async {
    var result = await repository.get(url);
    if (result != null) {
      return result.map(LyricAdapter.fromListMap);
    }
    return Stream.value([]);
  }

  @override
  Future<void> add(path, data) async {
    repository.add(path, data);
  }
  @override
  Future<void> update(String path, data) async{
    repository.update(path, data);
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
