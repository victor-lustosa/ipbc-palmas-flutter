abstract class IUseCases <R> {
  Future<R> get(String url);
  Future<void> add(String path, dynamic data);
}
