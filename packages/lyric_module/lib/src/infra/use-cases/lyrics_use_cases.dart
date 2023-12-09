import 'package:core_module/core_module.dart';

import '../../../lyric_module.dart';

class LyricsUseCases implements ILyricsUseCases<Stream<List<LyricEntity>>> {
  final IRepository<List<dynamic>> repository;

  LyricsUseCases({required this.repository});

  @override
  Future<Stream<List<LyricEntity>>> get(String url) async {
    var result = await repository.get(url);
    return Stream.value(SupaLyricAdapter.fromMapList(result));
  }

  @override
  Future<void> add(path, data) async {
    repository.add(path, data);
  }

  @override
  Future<void> update(String path, data) async {
    repository.update(path, data);
  }

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
