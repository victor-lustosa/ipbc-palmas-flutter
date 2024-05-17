abstract class IAuthDatasource
    implements
        ISignInEmailDatasource {}


abstract class ISignInEmailDatasource {
  Future<String> signInWithEmail(String email, String password);
}