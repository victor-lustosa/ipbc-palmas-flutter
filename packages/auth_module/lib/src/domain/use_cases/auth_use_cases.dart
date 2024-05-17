abstract class IAuthUseCases implements ISignInEmailUseCases {}

abstract class ISignInEmailUseCases {
  Future<String> signInWithEmail(String email, String password);
}

