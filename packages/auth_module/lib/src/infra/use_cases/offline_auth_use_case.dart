
import 'package:auth_module/src/domain/repositories/auth_repository.dart';

import '../../domain/use_cases/auth_use_cases.dart';


class OfflineAuthUseCase implements IOfflineAuthUseCases{

  final IAuthRepository repository;

  OfflineAuthUseCase({required this.repository});

  @override
  void get() {
  }

}