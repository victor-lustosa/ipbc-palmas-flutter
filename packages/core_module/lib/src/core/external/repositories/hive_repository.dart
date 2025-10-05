import 'dart:io';

import '../../../../core_module.dart';

class HiveRepository<R> implements IRepository {
  String boxLabel;
  late Box<R> box;

  static const String userHiveBox = 'user';
  static const String credentialsHiveBox = 'credentials';

  HiveRepository({required this.boxLabel}) {
    box = Hive.box<R>(boxLabel);
  }

  static Future init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(HiveCredentialsDTOAdapter());
    Hive.registerAdapter(HiveUserDTOAdapter());

    await Future.wait<void>([
          Hive.openBox<HiveUserDTO>(userHiveBox),
          Hive.openBox<HiveCredentialsDTO>(credentialsHiveBox),
    ]);
  }

  @override
  Future<dynamic> get<T>({Map<String, dynamic>? params})  async {
    var result;
   /* switch (params?['type']) {
      case credentialsHiveBox:
        result = box.get(params?['id']);
        return result != null ? HiveAuthAdapter.fromMap(result as HiveAuthDTO) : HiveAuthDTO.empty();
      case userHiveBox:
        result = box.get(params?['id']);
        return result != null ? HiveAuthAdapter.fromMap(result as HiveAuthDTO) : HiveAuthDTO.empty();
    }*/
    return null;
  }

  @override
  Future<dynamic> update<T>({
    required data,
    Map<String, dynamic>? params,
  }) async {
    //   box.put(path, HiveAuthAdapter.toDTO(data) as R);
  }

  @override
  Future<dynamic> delete<T>({Map<String, dynamic>? params}) async {
    box.delete(params);
  }

  @override
  Future<dynamic> add<T>({required data, Map<String, dynamic>? params}) {
    throw UnimplementedError();
  }

  @override
  Future getByPagination<T>({Map<String, dynamic>? params}) {
    throw UnimplementedError();
  }

  @override
  Future<String?> saveImage({required File coverImage, required String fileName, required String bucketName}) {
    throw UnimplementedError();
  }

  @override
  Future upsert<T>({required data, Map<String, dynamic>? params}) {
    throw UnimplementedError();
  }
}
