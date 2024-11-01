
import 'package:core_module/core_module.dart';

abstract class IOfflineAuthRepository implements IGet{}
abstract class IOnlineAuthRepository implements ISignInEmailService, ISignInGoogleService, IGetCurrentUserService{}
abstract class IGet {
  Future<dynamic> get(String path);
}

abstract class ISignInEmailService {
  Future<String> signInWithEmail(String email, String password);
}
abstract class ISignInGoogleService {
  Future<String?> signInWithGoogle();
}

abstract class IGetCurrentUserService {
  UserEntity getCurrentUser();
}