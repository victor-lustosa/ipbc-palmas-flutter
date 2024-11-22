
import 'package:core_module/core_module.dart';

abstract class ILyricsUseCases {
  Future<List<LyricEntity>> lettersFilter(
      List<LyricEntity> lyrics);
}
