
import '../../../../core_module.dart';

abstract class IOnlineAuthRepository
    implements ISignInEmail, ISignInGoogle, IGetCurrentUser, ISignInFacebook {}

abstract class ISignInEmail {
  Future<String?> signInWithEmail(String email, String password);
}

abstract class ISignInGoogle {
  Future<String?> signInWithGoogle();
}

abstract class ISignInFacebook {
  Future<void> signInFacebook();
}

abstract class IGetCurrentUser {
  UserEntity? getCurrentUser();
}

abstract class IOfflineAuthRepository
    implements IGetLocalUser, IGetToken, ISaveLocalUser , ISaveToken{}


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
