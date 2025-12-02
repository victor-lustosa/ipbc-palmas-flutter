import 'dart:io';
import 'package:dartz/dartz.dart';
import '../exceptions/generic_exception.dart';

abstract class IRepository
    implements IGet, IGetByPagination, IUpsert, IAdd, IDelete, IUpdate, ISaveImage {}

abstract class IGet {
  Future<Either<dynamic, GenericException>> get<T>({Map<String, dynamic>? params});
}

abstract class IGetByPagination {
  Future<Either<dynamic, GenericException>> getByPagination<T>({Map<String, dynamic>? params});
}

abstract class IUpsert {
  Future<Either<dynamic, GenericException>> upsert<T>({required dynamic data, Map<String, dynamic>? params});
}

abstract class IAdd {
  Future<Either<dynamic, GenericException>> add<T>({required dynamic data, Map<String, dynamic>? params});
}

abstract class IUpdate {
  Future<Either<void, GenericException>> update<T>({required dynamic data, Map<String, dynamic>? params});
}

abstract class IDelete {
  Future<Either<dynamic, GenericException>> delete<T>({Map<String, dynamic>? params});
}

abstract class ISaveImage {
  Future<Either<String?, GenericException>> saveImage({
    required File coverImage,
    required String fileName,
    required String bucketName,
  });
}
