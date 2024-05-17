
import 'package:core_module/core_module.dart';

abstract class ILyricsUseCases<R> implements IUseCases<R> {
  Future<List<LyricEntity>> lettersFilter(
      List<LyricEntity> lyrics);
}
