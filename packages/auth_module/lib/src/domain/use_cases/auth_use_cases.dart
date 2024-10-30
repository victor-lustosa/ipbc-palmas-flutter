
import 'package:core_module/core_module.dart';

abstract class IOfflineAuthUseCases implements IGetUserInMemoryUseCases {}

abstract class IOnlineAuthUseCases implements ISignInEmailUseCases, ISignInGoogleUseCases, IGetCurrentUserUseCases {}

abstract class ISignInEmailUseCases {
  Future<String> signInWithEmail(String email, String password);
}

abstract class ISignInGoogleUseCases {
  Future<String?> signInWithGoogle();
}

abstract class IGetCurrentUserUseCases{
  UserEntity getCurrentUser();
}

abstract class IGetUserInMemoryUseCases{
  void get();
}