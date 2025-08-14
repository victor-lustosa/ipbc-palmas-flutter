import 'dart:io';

import 'package:core_module/core_module.dart';

class UseCases<T> implements IUseCases {
  final IRepository repository;

  UseCases({required this.repository});

  @override
  Future<dynamic> get({Map<String, dynamic>? query, required Function converter}) async {
    var result = await repository.get(query: query);
    return converter(result);
  }

  @override
  Future<void> add({required data, String? path}) async =>
      repository.add(data: data, path: path);

  @override
  Future<void> update({required data, String? path}) async =>
      repository.update(data: data, path: path);

  @override
  Future<void> delete({String? path}) async => repository.delete(path: path);

  @override
  Future<String?> saveImage({required File coverImage, required String eventTitle}) {
    return repository.saveImage(coverImage: coverImage, eventTitle: eventTitle );
  }
}
