
import 'package:core_module/core_module.dart';

class UseCases implements IUseCases<Stream<List<dynamic>>> {
  final IRepository<List<dynamic>> repository;
  UseCases({required this.repository});

  @override
  Future<Stream<List<dynamic>>> get(String url) async {
    var result = await repository.get(url);
    return Stream.value(ServicesAdapter.fromMapList(result));
  }

  @override
  Future<void> add(path, data) async {
    repository.add(path, data);
  }

  @override
  Future<void> update(String path, data) async {
    repository.update(path, data);
  }
}
