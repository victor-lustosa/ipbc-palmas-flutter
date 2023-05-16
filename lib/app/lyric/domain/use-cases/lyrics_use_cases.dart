import '../../domain/entities/lyric_entity.dart';
import '../../../core/domain/use-cases/use_cases.dart';

abstract class ILyricsUseCases<R> implements IUseCases<R> {
  Future<List<LyricEntity>> lettersFilter(
      List<LyricEntity> lyrics, String letter);
}
