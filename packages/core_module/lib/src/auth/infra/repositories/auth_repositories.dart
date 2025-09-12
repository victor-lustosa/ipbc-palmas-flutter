import '../../../../../core_module.dart';

abstract class IOnlineAuthRepository
    implements
        ISignInEmail,
        ISignInGoogle,
        IGetCurrentUser,
        ISignInFacebook,
        IGetJWTToken,
        ICreateUser,
        ILogoutWithGoogle {}

abstract class IOfflineAuthRepository
    implements IGetLocalUser, IGetToken, ISaveLocalUser, ISaveToken {}

abstract class ISignInEmail {
  Future<String?> signInWithEmail(String email, String password);
}

abstract class ICreateUser {
  Future<String?> createUser(String email, String password);
}

abstract class ISignInGoogle {
  Future<String?> signInWithGoogle();
}

abstract class ILogoutWithGoogle {
  Future<void> logoutWithGoogle();
}

abstract class ISignInFacebook {
  Future<void> signInFacebook();
  Stream streamFacebook();
}

abstract class IGetJWTToken {
  String? getJWTToken();
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
