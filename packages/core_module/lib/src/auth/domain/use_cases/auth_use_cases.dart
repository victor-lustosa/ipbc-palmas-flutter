import '../../../../core_module.dart';

abstract class IAuthUseCases
    implements
        ISignInEmail,
        ISignInGoogle,
        ISignInFacebook,
        ILogout,
        IGetLocalUser,
        ISaveLocalUser,
        ICreateAccount,
        IGetCredentials,
        ISaveCredentials {}

abstract class ICreateAccount {
  Future<String?> createAccount(String email, String password);
}

abstract class ISignInEmail {
  Future<String?> signInWithEmail(String email, String password);
}

abstract class ISignInGoogle {
  Future<String?> signInWithGoogle();
}

abstract class ISignInFacebook {
  Future<void> signInWithFacebook();
  // Stream streamFacebook();
}

abstract class IGetCurrentUser {
  UserEntity? getCurrentUser();
}

abstract class IGetLocalUser {
  Future<UserEntity?> getLocalUser();
}

abstract class IGetCredentials {
  Future<String?> getCredentials();
}

abstract class ISaveLocalUser {
  void saveLocalUser(UserEntity user);
}

abstract class ILogout {
  dynamic logout({required String? provider});
}

abstract class ISaveCredentials {
  dynamic saveCredentials(AuthCredentials auth);
}
