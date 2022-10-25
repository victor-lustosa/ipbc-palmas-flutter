abstract class IGetRepository <T>{
  Stream<List<T>> get();
}
abstract class IAddRepository <T>{
  Future<void> add(T);
}
abstract class IUpdateRepository <T>{
  Future<void> update(T);
}
abstract class IDeleteRepository <T>{
  Future<void> delete(T);
}