
import 'package:auth_module/src/infra/repositories/auth_repositories.dart';
import 'package:core_module/core_module.dart';

import '../../domain/use_cases/auth_use_cases.dart';

class OfflineAuthUseCases implements IOfflineAuthUseCases{

  final IOfflineAuthRepository repository;

  OfflineAuthUseCases({required this.repository});

  @override
  Future<String?> getAccessToken() => repository.getAccessToken();

  @override
  Future<UserEntity?> getLocalUser() => repository.getLocalUser();

  @override
  void saveAccessToken(String token) => repository.saveAccessToken(token);

  @override
  void saveLocalUser(dynamic user) => repository.saveLocalUser(user);
}