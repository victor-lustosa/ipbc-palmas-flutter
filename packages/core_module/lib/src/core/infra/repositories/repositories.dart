import 'dart:io';

abstract class IRepository
    implements IGet, IGetByPagination, IAdd, IDelete, IUpdate, ISaveImage {}

abstract class IGet {
  Future<dynamic> get<T>({Map<String, dynamic>? params});
}

abstract class IGetByPagination {
  Future<dynamic> getByPagination<T>({Map<String, dynamic>? params});
}

abstract class IAdd {
  Future<void> add<T>({required data, Map<String, dynamic>? params});
}

abstract class IUpdate {
  Future<void> update<T>({required data, Map<String, dynamic>? params});
}

abstract class IDelete {
  Future<void> delete<T>({Map<String, dynamic>? params});
}

abstract class ISaveImage {
  Future<String?> saveImage({
    required File coverImage,
    required String fileName,
    required String bucketName,
  });
}
