
import 'package:core_module/core_module.dart';

abstract class IOnlineAuthRepository implements ISignInEmail, ISignInGoogle, IGetCurrentUser{}

abstract class ISignInEmail {
  Future<String?> signInWithEmail(String email, String password);
}

abstract class ISignInGoogle {
  Future<String?> signInWithGoogle();
}

abstract class IGetCurrentUser {
  UserEntity? getCurrentUser();
}
