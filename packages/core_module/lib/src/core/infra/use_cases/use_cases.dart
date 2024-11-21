
import 'package:core_module/core_module.dart';

class UseCases<T> implements IUseCases<T> {
  final IRepository repository;
  UseCases({required this.repository});

  @override
  Future<T?> get({required String path, Function? fromMapList}) async {
    var result = await repository.get(path);
    if(fromMapList == null) return null;
    return Stream.value(fromMapList(result)) as T;
  }

  @override
  Future<void> add(path, data) async => repository.add(path, data);

  @override
  Future<void> update(String path, data) async => repository.update(path, data);
}
