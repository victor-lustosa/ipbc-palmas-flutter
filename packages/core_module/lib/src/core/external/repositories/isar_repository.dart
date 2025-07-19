import '../../../../core_module.dart';

class IsarRepository implements IRepository {
  final Isar isar;
  List<String> params = [];
  IsarRepository({required this.isar});

  static Future init() async {
    final dir = await getApplicationDocumentsDirectory();
    await Isar.open([
      IsarTokenDTOSchema,
      IsarUserDTOSchema,

    ], directory: dir.path);
  }

  @override
  Future<dynamic> get<T>({String? path}) async {
    final entity = await isar.collection<T>().where().findAll();
    if(entity.isNotEmpty){
      return Future.value(entity[0]);
    } else {
      return null;
    }
  }

  @override
  Future<void> update<T>({required data, String? path}) async {
    await isar.writeTxn(() async {
      isar.collection<T>().put(data);
    });
  }

  @override
  Future<void> delete<T>({String? path}) async {}

  @override
  Future<void> add<T>({required data, String? path}) async =>
      update<T>(data: data, path: path);

  @override
  Future<dynamic> getByPagination<T>({String? path}) async {
    path ??= '';
    params = path.split('/');
    int page = int.parse(params[0]);
    int pageSize = int.parse(params[1]);
    return await isar.collection<T>()
        .where()
        .offset((page - 1) * pageSize)
        .limit(pageSize)
        .findAll();
  }
}
