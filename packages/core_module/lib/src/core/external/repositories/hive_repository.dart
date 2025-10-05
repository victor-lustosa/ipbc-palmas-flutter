import 'dart:io';

import '../../../../core_module.dart';

class HiveRepository implements IRepository {
  static const String userHiveBox = 'user';
  static const String credentialsHiveBox = 'credentials';

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
  Future<dynamic> get<T>({Map<String, dynamic>? params}) async {
    final Box<T> box = _getBoxForType<T>();
    switch (params?['type']) {
      case credentialsHiveBox:
        var value = box.get(credentialsHiveBox);
        return value != null ? AuthCredentials.fromHive(value as HiveCredentialsDTO) : null;
      case userHiveBox:
        var value = box.get(userHiveBox);
        return value != null ? UserEntity.fromHive(value as HiveUserDTO) : null;
    }
  }

  Box<T> _getBoxForType<T>() {
    if (T == HiveUserDTO) {
      return Hive.box<T>(userHiveBox);
    } else if (T == HiveCredentialsDTO) {
      return Hive.box<T>(credentialsHiveBox);
    }
    throw Exception('Hive box for type $T not found');
  }

  @override
  Future<dynamic> update<T>({
    required data,
    Map<String, dynamic>? params,
  }) async {
    final Box box = _getBoxForType<T>();
    switch (params?['type']) {
      case credentialsHiveBox:
        box.put(credentialsHiveBox, HiveCredentialsDTO.create(data as AuthCredentials));
        break;
      case userHiveBox:
        box.put(userHiveBox, HiveUserDTO.create(data as UserEntity));
        break;
    }
  }

  @override
  Future<dynamic> delete<T>({Map<String, dynamic>? params}) async {
    final Box box = _getBoxForType<T>();
    final key = params?['key'];
    if (key != null) {
      await box.delete(key);
    } else {
      await box.clear();
    }
  }

  @override
  Future<dynamic> add<T>({required data, Map<String, dynamic>? params}) =>
      update<T>(data: data, params: params);

  @override
  Future<List<T>> getByPagination<T>({Map<String, dynamic>? params}) async {
    final Box box = _getBoxForType<T>();
    final int page = params?["page"] ?? 1;
    final int pageSize = params?["pageSize"] ?? 10;

    final items = box.values
        .skip((page - 1) * pageSize)
        .take(pageSize)
        .toList();

    return items as List<T>;
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
