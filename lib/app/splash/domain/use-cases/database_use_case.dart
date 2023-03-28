import '../../../core/domain/use-cases/use_cases.dart';

abstract class IDatabaseUseCases <R> extends IUseCases<R>{
  Future<void> add(String path, dynamic data);
}


