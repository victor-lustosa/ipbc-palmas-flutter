import 'dart:io';

import 'package:core_module/core_module.dart';

class UseCases<T> implements IUseCases {
  final IRepository repository;

  UseCases({required this.repository});

  @override
  Future<dynamic> get({
    Map<String, dynamic>? params,
    required Function converter,
  }) async {
    var result = await repository.get(params: params);
    return converter(result);
  }

  @override
  Future<dynamic> add({required data, Map<String, dynamic>? params}) async =>
      repository.add(data: data, params: params);

  @override
  Future<void> update({required data, Map<String, dynamic>? params}) async =>
      repository.update(data: data, params: params);

  @override
  Future<void> delete({Map<String, dynamic>? params}) async =>
      repository.delete(params: params);

  @override
  Future<String?> saveImage({
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

  @override
  Future<dynamic> upsert({required data, Map<String, dynamic>? params}) =>
      repository.add(data: data, params: params);
}
