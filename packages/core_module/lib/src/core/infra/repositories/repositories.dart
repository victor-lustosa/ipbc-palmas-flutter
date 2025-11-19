import 'dart:io';

abstract class IRepository
    implements IGet, IGetByPagination, IUpsert, IAdd, IDelete, IUpdate, ISaveImage {}

abstract class IGet {
  Future<dynamic> get<T>({Map<String, dynamic>? params});
}

abstract class IGetByPagination {
  Future<dynamic> getByPagination<T>({Map<String, dynamic>? params});
}

abstract class IUpsert {
  Future<dynamic> upsert<T>({required dynamic data, Map<String, dynamic>? params});
}

abstract class IAdd {
  Future<dynamic> add<T>({required dynamic data, Map<String, dynamic>? params});
}

abstract class IUpdate {
  Future<void> update<T>({required dynamic data, Map<String, dynamic>? params});
}

abstract class IDelete {
  Future<dynamic> delete<T>({Map<String, dynamic>? params});
}

abstract class ISaveImage {
  Future<String?> saveImage({
    required File coverImage,
    required String fileName,
    required String bucketName,
  });
}
