
import 'package:core_module/core_module.dart';

abstract class IOnlineAuthRepository implements ISignInEmailService, ISignInGoogleService, IGetCurrentUserService{}

abstract class ISignInEmailService {
  Future<String> signInWithEmail(String email, String password);
}
abstract class ISignInGoogleService {
  Future<String?> signInWithGoogle();
}

abstract class IGetCurrentUserService {
  UserEntity getCurrentUser();
}