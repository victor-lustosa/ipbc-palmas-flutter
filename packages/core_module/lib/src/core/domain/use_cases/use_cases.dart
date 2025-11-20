import 'dart:io';

abstract class IUseCases
    implements
        IGetUseCases,
        IAddUseCases,
        IUpsertUseCases,
        IUpdateUseCases,
        IDeleteUseCases,
        ISaveImageUseCases {}

abstract class IGetUseCases {
  Future<dynamic> get({
    Map<String, dynamic>? params,
    required Function converter,
  });
}

abstract class IUpsertUseCases {
  Future<dynamic> upsert({required dynamic data, Map<String, dynamic>? params});
}

abstract class IAddUseCases {
  Future<dynamic> add({required dynamic data, Map<String, dynamic>? params});
}

abstract class IUpdateUseCases {
  Future<void> update({required dynamic data, Map<String, dynamic>? params});
}

abstract class IDeleteUseCases {
  Future<dynamic> delete({Map<String, dynamic>? params});
}

abstract class ISaveImageUseCases {
  Future<String?> saveImage({
    required File coverImage,
    required String fileName,
    required String bucketName,
  });
}

