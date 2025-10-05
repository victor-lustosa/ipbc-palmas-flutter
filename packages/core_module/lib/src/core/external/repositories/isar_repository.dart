/*import 'dart:io';

import '../../../../core_module.dart';

class IsarRepository implements IRepository {
  final Isar isar;
  List<String> params = [];

  IsarRepository({required this.isar});

  static Future init() async {
    final dir = await getApplicationDocumentsDirectory();
    await Isar.open([
      IsarCredentialsDTOSchema,
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
  Future<dynamic> update<T>({
    required data,
    Map<String, dynamic>? params,
  }) async {
    isar.writeTxn(() async {
      final int id = await isar.collection<T>().put(data);
      return id;
    });
  }

  @override
  Future<dynamic> delete<T>({Map<String, dynamic>? params}) async {
    if(params?['id'] != null) {
      isar.writeTxn(() async {
        final success = await isar.collection<T>().delete(params?['id']);
        return success;
      });
    } else {
      isar.writeTxn(() async {
        final success = await isar.collection<T>().where().deleteAll();
        return success;
      });
    }
  }

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
*/