
import 'package:ipbc_palmas/app/core/domain/use-cases/use_cases.dart';

abstract class ILyricsUseCases <T,R> extends IUseCases<R>{
  Future<List<T>> lettersFilter(
      List<T> lyrics, String letter);
}


