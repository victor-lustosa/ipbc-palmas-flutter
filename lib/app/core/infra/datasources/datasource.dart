abstract class IGetDatasource {
  Stream<List<Map>> get();
}
abstract class IAddDatasource {
  Stream<List<Map>> add();
}
abstract class IDeleteDatasource {
  Stream<List<Map>> delete();
}
abstract class IUpdateDatasource {
  Stream<List<Map>> update();
}
