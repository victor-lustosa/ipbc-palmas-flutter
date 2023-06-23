import '../../../../core_module.dart';

abstract class ILyricsUseCases<R> implements IUseCases<R> {
  Future<List<LyricEntity>> lettersFilter(
      List<LyricEntity> lyrics, String letter);
}
