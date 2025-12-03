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
  Future<Either<dynamic, GenericException>> get<T>({Map<String, dynamic>? params}) async {
    final Box<T> box = _getBoxForType<T>();
    try{
      switch (params?['type']) {
        case credentialsHiveBox:
          var value = box.get(credentialsHiveBox);
          return left(value != null ? AuthCredentials.fromHive(value as HiveCredentialsDTO) : null);
        case userHiveBox:
          var value = box.get(userHiveBox);
          return left(value != null ? UserEntity.fromHive(value as HiveUserDTO) : null);
      }
      return left(null);
    } on HiveException catch (e) {
      return right(GenericException(message: e.message));
    }
  }

  Box<T> _getBoxForType<T>() {
    if (T == HiveUserDTO) {
      return Hive.box<T>(userHiveBox);
    } else if (T == HiveCredentialsDTO) {
      return Hive.box<T>(credentialsHiveBox);
    }
    throw HiveException(message: 'Hive box for type $T not found');
  }

  @override
  Future<Either<dynamic, GenericException>> update<T>({
    required data,
    Map<String, dynamic>? params,
  }) async {
    try{
      final Box box = _getBoxForType<T>();
      switch (params?['type']) {
        case credentialsHiveBox:
          box.put(credentialsHiveBox, HiveCredentialsDTO.create(data as AuthCredentials));
          break;
        case userHiveBox:
          box.put(userHiveBox, HiveUserDTO.create(data as UserEntity));
          break;
      }
      return left(null);
    } on HiveException catch (e) {
      return right(GenericException(message: e.message));
    }
  }

  @override
  Future<Either<dynamic, GenericException>> delete<T>({Map<String, dynamic>? params}) async {
    try{
      final Box box = _getBoxForType<T>();
      final key = params?['key'];
      if (key != null) {
        await box.delete(key);
      } else {
        await box.clear();
      }
      return left(null);
    }on PostgrestException catch (e){
      return right(GenericException(details: e.details, message: e.message, code: e.code));
    }
  }

  @override
  Future<Either<dynamic, GenericException>>  add<T>({required data, Map<String, dynamic>? params}) =>
      update<T>(data: data, params: params);

  @override
  Future<Either<List<T>, GenericException>> getByPagination<T>({Map<String, dynamic>? params}) async {
   try{
     final Box box = _getBoxForType<T>();
     final int page = params?["page"] ?? 1;
     final int pageSize = params?["pageSize"] ?? 10;

     final items = box.values
         .skip((page - 1) * pageSize)
         .take(pageSize)
         .toList();

     return left(items as List<T>);
   } catch(e){
     return right(GenericException(message: 'Erro ao buscar dados: $e'));
   }
  }

  @override
  Future<Either<String?, GenericException>> saveImage({
    required File coverImage,
    required String fileName,
    required String bucketName,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<dynamic, GenericException>> upsert<T>({required data, Map<String, dynamic>? params}) {
    throw UnimplementedError();
  }
}
