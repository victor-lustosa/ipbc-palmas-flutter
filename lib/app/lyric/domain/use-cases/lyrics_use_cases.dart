import '../entities/lyric_entity.dart';
import '../repositories/lyric_repository.dart';

abstract class ILyricsUseCases {
  Stream<List<LyricEntity>> call();
}

class LyricsUseCases implements ILyricsUseCases {
  final ILyricRepository<LyricEntity> repository;

  LyricsUseCases(this.repository);

  @override
  Stream<List<LyricEntity>> call() {
    return repository.get();
  }
}
