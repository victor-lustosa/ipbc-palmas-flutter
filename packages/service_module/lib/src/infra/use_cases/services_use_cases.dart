
import 'package:core_module/core_module.dart';

class ServicesUseCases<T> implements IUseCases<Stream<List<ServicesEntity>>> {
  final IRepository repository;
  ServicesUseCases({required this.repository});

  @override
  Future<Stream<List<ServicesEntity>>> get({required String path, Function? fromMapList}) async {
    var result = await repository.get(path);
    return Stream.value(ServicesAdapter.fromMapList(result));
  }

  @override
  Future<void> add(path, data) async => repository.add(path, data);

  @override
  Future<void> update(String path, data) async => repository.update(path, data);
}
