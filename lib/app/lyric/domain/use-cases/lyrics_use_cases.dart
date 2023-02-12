import 'package:ipbc_palmas/app/lyric/infra/adapters/lyric_adapter.dart';

import '../../../core/infra/repositories/repository.dart';
import '../entities/lyric_entity.dart';

abstract class ILyricsUseCases {
  Stream<List<LyricEntity>> get(String url);
  Future<List<LyricEntity>> lettersFilter(
      List<LyricEntity> lyrics, String letter);
}

class LyricsUseCases implements ILyricsUseCases {
  final IRepository<LyricEntity> repository;
  LyricsUseCases({required this.repository});

  List<LyricEntity> _convert(List<Map<dynamic, dynamic>> list) {
    return list.map(LyricAdapter.fromMap).toList();
  }

  @override
  Stream<List<LyricEntity>> get(String url) {
    var lyrics = repository.get(url);
    return lyrics.map(_convert);
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
