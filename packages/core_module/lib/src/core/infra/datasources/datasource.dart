abstract class IDatasource<R>
    implements
        IGetDatasource,
        IAddDatasource,
        IDeleteDatasource,
        IUpdateDatasource {}

abstract class IAuth<R>
    implements
        ISignInEmailDatasource {}

abstract class IGetDatasource <R> {
  Future<R?> get(String path);
}

abstract class ISignInEmailDatasource {
  Future<String> signInWithEmail(String email, String password);
}

abstract class IAddDatasource {
  Future<void> add(String path, data);
}

abstract class IDeleteDatasource {
  Future<void> delete(String path );
}

abstract class IUpdateDatasource {
  Future<void> update(String path, data);
}