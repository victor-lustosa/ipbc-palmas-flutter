abstract class IAuthUseCases<R> implements ISignInEmailUseCases<R> {}

abstract class ISignInEmailUseCases<R> {
  Future<String> signInWithEmail(String email, String password);
}

