import 'dart:io';

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
  Future<dynamic> get<T>({Map<String, dynamic>? params}) async {
    final entity = await isar.collection<T>().where().findAll();
    if (entity.isNotEmpty) {
      return Future.value(entity[0]);
    } else {
      return null;
    }
  }

  @override
  Future<String?> update<T>({required data, Map<String, dynamic>? params}) async {
   return await isar.writeTxn(() async {
      isar.collection<T>().put(data);
      return null;
    });
  }

  @override
  Future<void> delete<T>({Map<String, dynamic>? params}) async {}

  @override
  Future<dynamic> add<T>({required data, Map<String, dynamic>? params}) async =>
      update<T>(data: data, params: params);

  @override
  Future<dynamic> getByPagination<T>({Map<String, dynamic>? params}) async {
    int page = int.parse(params?["page"] ?? "1");
    int pageSize = int.parse(params?["pageSize"]);
    return await isar
        .collection<T>()
        .where()
        .offset((page - 1) * pageSize)
        .limit(pageSize)
        .findAll();
  }

  @override
  Future<String?> saveImage({
    required File coverImage,
    required String fileName,
    required String bucketName,
  }) {
    throw UnimplementedError();
  }

  @override
  Future upsert<T>({required data, Map<String, dynamic>? params}) {
    throw UnimplementedError();
  }
}
