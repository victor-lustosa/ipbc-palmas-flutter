import 'package:core_module/core_module.dart';

class UseCases<T> implements IUseCases {
  final IRepository repository;

  UseCases({required this.repository});

  @override
  Future<dynamic> get({
    String? path,
    String? id,
    required Function converter,
  }) async {
    var result = await repository.get(path: path, id: id);
    return converter(result);
  }

  @override
  Future<void> add({required data, String? path, String? id}) async =>
      repository.add(data: data, path: path, id: id);

  @override
  Future<void> update({required data, String? path, String? id}) async =>
      repository.update(data: data, path: path, id: id);

  @override
  Future<void> delete({String? path, String? id}) async =>
      repository.delete(path: path, id: id);
}
