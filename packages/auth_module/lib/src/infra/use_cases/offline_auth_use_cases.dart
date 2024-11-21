
import 'package:auth_module/src/domain/repositories/auth_repositories.dart';

import '../../domain/use_cases/auth_use_cases.dart';

class OfflineAuthUseCases implements IOfflineAuthUseCases{

  final IOfflineAuthRepository repository;

  OfflineAuthUseCases({required this.repository});

  @override
  void getAccessToken() {
    return repository.getAccessToken();
  }

  @override
  void getLocalUser() {
    return repository.getLocalUser();
  }

  @override
  void saveAccessToken(String token) {
    repository.saveAccessToken(token);
  }

  @override
  void saveLocalUser(dynamic user) {
    repository.saveLocalUser(user);
  }
}