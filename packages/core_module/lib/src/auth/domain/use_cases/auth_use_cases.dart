
import '../../../../core_module.dart';

abstract class IOfflineAuthUseCases
    implements IGetLocalUser, ISaveLocalUser, IGetToken, ISaveToken {}

abstract class IOnlineAuthUseCases
    implements ISignInEmail, ISignInGoogle, IGetCurrentUser, ISignInFacebook {}

abstract class ISignInEmail {
  Future<String?> signInWithEmail(String email, String password);
}

abstract class ISignInGoogle {
  Future<String?> signInWithGoogle();
}
abstract class ISignInFacebook {
  Future<void> signInWithFacebook();
}
abstract class IGetCurrentUser {
  UserEntity? getCurrentUser();
}

abstract class IGetLocalUser {
  Future<UserEntity?> getLocalUser();
}

abstract class IGetToken {
  Future<String?> getToken();
}

abstract class ISaveLocalUser {
  void saveLocalUser(UserEntity user);
}

abstract class ISaveToken {
  void saveToken(String token);
}
