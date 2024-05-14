
import 'package:auth_module/src/domain/repositories/auth_repository.dart';
import 'package:auth_module/src/domain/use_cases/auth_use_cases.dart';

class AuthUseCase implements IAuthUseCases{

  final IAuthRepository repository;

  AuthUseCase({required this.repository});

  @override
  Future<String> signInWithEmail(String email, String password) {
    var dfd = repository.signInWithEmail(email);
    return Future.value(dfd as String);
  }
}