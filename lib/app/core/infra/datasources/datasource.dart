abstract class IDatasource<R>
    implements
        IGetDatasource<R>,
        IAddDatasource,
        IDeleteDatasource,
        IUpdateDatasource {}

abstract class IGetDatasource<R> {
  R get(String path);
}

abstract class IAddDatasource {
  Future<void> add(String path, data);
}

abstract class IDeleteDatasource {
  Future<void> delete(String path, data);
}

abstract class IUpdateDatasource {
  Future<void> update(String path, data);
}
