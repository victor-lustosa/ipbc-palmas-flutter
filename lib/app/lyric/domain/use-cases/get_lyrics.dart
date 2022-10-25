import '../entities/lyric_entity.dart';
import '../repositories/lyric_repository.dart';

abstract class IGetLyrics {
  Stream<List<LyricEntity>> call();
}

class GetLyrics implements IGetLyrics {
  final ILyricRepository<LyricEntity> repository;

  GetLyrics(this.repository);

  @override
  Stream<List<LyricEntity>> call() {
    return repository.get();
  }
}
