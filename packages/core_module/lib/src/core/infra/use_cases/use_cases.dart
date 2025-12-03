import 'dart:io';
import 'package:core_module/core_module.dart';

class UseCases<T> implements IUseCases {
  final IRepository repository;

  UseCases({required this.repository});

  @override
  Future<dynamic> get({
    Map<String, dynamic>? params
  }) async => repository.get(params: params);

  @override
  Future<dynamic> add({required data, Map<String, dynamic>? params}) async =>
      repository.add(data: data, params: params);

  @override
  Future<void> update({required data, Map<String, dynamic>? params}) async =>
      repository.update(data: data, params: params);

  @override
  Future<dynamic> delete({Map<String, dynamic>? params}) async =>
      repository.delete(params: params);

  @override
  Future<dynamic> upsert({required data, Map<String, dynamic>? params}) =>
      repository.upsert(data: data, params: params);

  @override
  Future<Either<String?, GenericException>> saveImage({
    required File coverImage,
    required String fileName,
    required String bucketName,
  }) {
    return repository.saveImage(
      coverImage: coverImage,
      fileName: fileName,
      bucketName: bucketName,
    );
  }


}
