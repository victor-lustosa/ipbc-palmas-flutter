abstract class IGetRepository <T>{
  Stream<List<Map<dynamic, dynamic>>> get(String url);
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