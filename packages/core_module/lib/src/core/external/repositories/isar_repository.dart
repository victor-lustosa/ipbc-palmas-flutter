import '../../../../core_module.dart';

class IsarRepository<T> implements IRepository {

  static late Isar isar;

  IsarRepository();

  static Future init() async {
    final dir = await getApplicationDocumentsDirectory();
     isar = await Isar.open(
      [IsarTokenDTOSchema, IsarUserDTOSchema],
      directory: dir.path,
    );
  }

  @override
  Future<dynamic> get({String? path, String? id}) async {
    final entity = await isar.collection<T>().where().findAll();
    return Future.value(entity);
  }

  @override
  Future<void> update({required data, String? path, String? id}) async {
    await isar.writeTxn(() async {
      isar.collection<T>().put(data);
    });
  }

  @override
  Future<void> delete({String? path, String? id}) async {

  }

  @override
  Future<void> add({required data, String? path, String? id}) async => update(data:data, path: path, id: id);
}
