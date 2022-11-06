abstract class IGetDatasource {
  Stream<List<Map>> get(String url);
}
abstract class IAddDatasource {
 Future<void> add(String url, data);
}
abstract class IDeleteDatasource {
  Future<void> delete(String url, id);
}
abstract class IUpdateDatasource {
  Future<void> update(String url, id);
}
