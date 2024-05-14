
import 'package:core_module/core_module.dart';

class ServicesUseCases implements IUseCases<Stream<List<ServicesEntity>>> {
  final IRepository<List<dynamic>> repository;
  ServicesUseCases({required this.repository});

  @override
  Future<Stream<List<ServicesEntity>>> get(String url) async {
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
