import '../../../core/domain/repositories/repository.dart';
import '../../../core/domain/use-cases/use_cases.dart';
import '../../domain/entities/services_list_entity.dart';
import '../adapters/service_adapter.dart';

class ServicesUseCases implements IUseCases<Stream<ServicesListEntity>> {
  final IRepository<Stream<List<Map>>> repository;
  ServicesUseCases({required this.repository});

  @override
  Future<Stream<ServicesListEntity>> get(String url) async {
    var result = await repository.get(url);
    if(result != null){
      return result.map(_convert);
    }
    return Stream.value(const ServicesListEntity(servicesList: [],createAt: '2000-01-01'));
  }

  ServicesListEntity _convert(List<Map> entity) {
    return ServiceAdapter.servicesListFromMapList(entity);
  }

  @override
  Future<void> add(path, data) async {
    repository.add(path, data);
  }
}