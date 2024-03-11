abstract class IAuthRepository<R>
    implements
        ISignInEmailRepository{}

abstract class ISignInEmailRepository {
  Future signInWithEmail(String path);
}
