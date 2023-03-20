
import 'package:ipbc_palmas/app/lyric/domain/entities/lyric_entity.dart';

import '../../../core/domain/use-cases/use_cases.dart';

abstract class ILyricsUseCases <R> extends IUseCases<R>{
  Future<List<LyricEntity>> lettersFilter(
      List<LyricEntity> lyrics, String letter);
}


