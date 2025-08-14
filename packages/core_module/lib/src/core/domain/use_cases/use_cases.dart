import 'dart:io';

abstract class IUseCases
    implements
        IGetUseCases,
        IAddUseCases,
        IUpdateUseCases,
        IDeleteUseCases,
        ISaveImageUseCases {}

abstract class IGetUseCases {
  Future<dynamic> get({
    Map<String, dynamic>? query,
    required Function converter,
  });
}

abstract class IAddUseCases {
  Future<void> add({required data, String? path});
}

abstract class IUpdateUseCases {
  Future<void> update({required data, String? path});
}

abstract class IDeleteUseCases {
  Future<void> delete({String? path});
}

abstract class ISaveImageUseCases {
  Future<String?> saveImage({
    required File coverImage,
    required String fileName,
    required String bucketName,
  });
}
