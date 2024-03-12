abstract class IAuthDatasource<R>
    implements
        ISignInEmailDatasource {}


abstract class ISignInEmailDatasource {
  Future<String> signInWithEmail(String email, String password);
}