abstract class IAuthRepository
    implements
        ISignInEmailRepository{}

abstract class ISignInEmailRepository {
  Future signInWithEmail(String path);
}
