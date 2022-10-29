import '../entities/lyric_entity.dart';
import '../repositories/lyric_repository.dart';

abstract class ILyricsUseCases {
  Stream<List<LyricEntity>> get();
}

class LyricsUseCases implements ILyricsUseCases {
  final ILyricRepository<LyricEntity> repository;

  LyricsUseCases({required this.repository});

  @override
  Stream<List<LyricEntity>> get() {
    return repository.get();
  }
}
