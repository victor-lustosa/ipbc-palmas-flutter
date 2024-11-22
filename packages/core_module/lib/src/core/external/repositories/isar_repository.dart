import '../../../../core_module.dart';

class IsarRepository implements IRepository {
  final Isar isar;

  IsarRepository({required this.isar});

  static Future init() async {
    final dir = await getApplicationDocumentsDirectory();
    await Isar.open(
      [IsarTokenDTOSchema, IsarUserDTOSchema],
      directory: dir.path,
    );
  }

  @override
  Future<dynamic> get<T>({String? path, String? id}) async {
    final entity = await isar.collection<T>().where().findAll();
    return Future.value(entity);
  }

  @override
  Future<void> update<T>({required data, String? path, String? id}) async {
      await isar.writeTxn(() async {
        isar.collection<T>().put(data);
      });
  }

  @override
  Future<void> delete<T>({String? path, String? id}) async {}

  @override
  Future<void> add<T>({required data, String? path, String? id}) async =>
      update<T>(data: data, path: path, id: id);
}
