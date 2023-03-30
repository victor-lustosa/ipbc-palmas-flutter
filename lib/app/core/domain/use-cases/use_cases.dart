abstract class IUseCases<R> implements IGetUseCases<R>, IAddUseCases {}

abstract class IGetUseCases<R> {
  Future<R> get(String url);
}

abstract class IAddUseCases {
  Future<void> add(String path, dynamic data);
}
