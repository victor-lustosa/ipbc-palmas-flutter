import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../infra/exceptions/generic_exception.dart';

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
    Map<String, dynamic>? params
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
  Future<Either<String?, GenericException>> saveImage({
    required File coverImage,
    required String fileName,
    required String bucketName,
  });
}

