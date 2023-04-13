import '../../../core/domain/repositories/repository.dart';
import '../../../core/domain/use-cases/use_cases.dart';
import '../../domain/entities/service_entity.dart';
import '../adapters/service_adapter.dart';

class ServicesUseCases implements IUseCases<Stream<List<ServiceEntity>>>{
  final IRepository<Stream<List<Map>>> repository;
  ServicesUseCases({required this.repository});

  @override
  Future<Stream<List<ServiceEntity>>> get(String url) async {
    var result = await repository.get(url);
    if (result != null) {
      return result.map(ServiceAdapter.fromMapList);
    }
    return Stream.value([]);
  }

  @override
  Future<void> add(path, data) async {
    repository.add(path, data);
  }

  @override
  Future<void> update(path, data) async {
    repository.update(path, data);
  }

}
