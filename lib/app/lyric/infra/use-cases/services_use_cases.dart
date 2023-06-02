import '../adapters/services_adapter.dart';
import '../../domain/entities/services_entity.dart';
import '../../../core/domain/use-cases/use_cases.dart';
import '../../../core/domain/repositories/repository.dart';

class ServicesUseCases implements IUseCases<Stream<List<ServicesEntity>>> {
  final IRepository<Stream<List<Map>>> repository;
  ServicesUseCases({required this.repository});

  @override
  Future<Stream<List<ServicesEntity>>> get(String url) async {
    var result = await repository.get(url);
    if (result != null) {
      return result.map(ServicesAdapter.fromMapList);
    }
    return Stream.value([]);
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
