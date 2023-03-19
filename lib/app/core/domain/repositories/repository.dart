abstract class IRepository<R>
    implements
        IGetRepository<R>,
        IAddRepository,
        IUpdateRepository,
        IDeleteRepository {}

abstract class IGetRepository<R> {
  R get(String path);
}

abstract class IAddRepository {
  Future<void> add(String path, data);
}

abstract class IUpdateRepository {
  Future<void> update(String path, data);
}

abstract class IDeleteRepository {
  Future<void> delete(String path, data);
}
