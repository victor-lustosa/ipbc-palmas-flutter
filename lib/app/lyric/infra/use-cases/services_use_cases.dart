import '../../../core/domain/repositories/repository.dart';
import '../../../core/domain/use-cases/use_cases.dart';
import '../../domain/entities/service_entity.dart';
import '../adapters/service_adapter.dart';


class ServicesUseCases implements IUseCases<Stream<List<ServiceEntity>>> {
  final IRepository<Stream<List<Map>>> repository;
  ServicesUseCases({required this.repository});

  List<ServiceEntity> _convert(List<Map> entity) {
    return ServiceAdapter.servicesListDecode(entity);
  }

  @override
  Stream<List<ServiceEntity>> get(String url) {
    return repository.get(url).map(_convert);
  }
}