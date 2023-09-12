abstract class IUseCases<R>
    implements IGetUseCases<R>, IAddUseCases, IUpdateUseCases {}

abstract class IGetUseCases<R> {
  Future<R?> get(String url);
}

abstract class IAddUseCases {
  Future<void> add(String path, dynamic data);
}

abstract class IUpdateUseCases {
  Future<void> update(String path, dynamic data);
}
