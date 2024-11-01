abstract class IRepository<R>
    implements
        IGet,
        IAdd,
        IDelete,
        IUpdate {}

abstract class IGet <R> {
  Future<R?> get(String path);
}

abstract class IAdd {
  Future<void> add(String path, data);
}

abstract class IDelete {
  Future<void> delete(String path );
}

abstract class IUpdate {
  Future<void> update(String path, data);
}