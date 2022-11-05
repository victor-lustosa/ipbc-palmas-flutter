import '../entities/lyric_entity.dart';
import '../repositories/lyric_repository.dart';

abstract class ILyricsUseCases {
  Stream<List<LyricEntity>> get();
  Future<List<LyricEntity>> lettersFilter(List<LyricEntity> lyrics, String letter);
}

class LyricsUseCases implements ILyricsUseCases {
  final ILyricRepository<LyricEntity> repository;

  LyricsUseCases({required this.repository});

  @override
  Stream<List<LyricEntity>> get() {
    return repository.get();
  }
  @override
  Future<List<LyricEntity>> lettersFilter(List<LyricEntity> lyrics, String letter) {
    return repository.filter(lyrics,letter);
  }
}
