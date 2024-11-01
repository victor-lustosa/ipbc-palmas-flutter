
import 'package:auth_module/src/domain/use_cases/auth_use_cases.dart';
import 'package:core_module/core_module.dart';

import '../../domain/repositories/auth_repositories.dart';

class OnlineAuthUseCases implements IOnlineAuthUseCases{

  final IOnlineAuthRepository service;

  OnlineAuthUseCases({required this.service});

  @override
  Future<String> signInWithEmail(String email, String password) {
    var entity = service.signInWithEmail(email, password);
    return Future.value(entity as String);
  }

  @override
  UserEntity getCurrentUser() {
    return service.getCurrentUser();
  }

  @override
  Future<String?> signInWithGoogle() async{
    return await service.signInWithGoogle();
  }
}