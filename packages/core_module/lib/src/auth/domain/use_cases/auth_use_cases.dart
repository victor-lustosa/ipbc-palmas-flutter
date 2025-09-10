
import '../../../../core_module.dart';
import '../../../core/domain/entities/auth/auth_credentials.dart';

abstract class IOfflineAuthUseCases
    implements IGetLocalUser, ISaveLocalUser, IGetToken, ISaveToken, ILogout{}

abstract class IOnlineAuthUseCases
    implements ISignInEmail, ISignInGoogle, IGetCurrentUser, ISignInFacebook, ILogout{}

abstract class ISignInEmail {
  Future<String?> signInWithEmail(String email, String password);
}

abstract class ISignInGoogle {
  Future<String?> signInWithGoogle();
}
abstract class ISignInFacebook {
  Future<void> signInWithFacebook();
  Stream streamFacebook();
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

abstract class ILogout {
  dynamic logoutWithGoogle({Map<String, dynamic>? params});
}

abstract class ISaveToken {
  void saveCredentials(AuthCredentials auth);
}
