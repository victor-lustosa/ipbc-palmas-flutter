import '../../../core/infra/repositories/repository.dart';
import '../../domain/entities/service_entity.dart';
import '../../domain/use-cases/services_use_cases.dart';
import '../adapters/service_adapter.dart';

class ServicesUseCases implements IServicesUseCases {
  final IRepository<ServiceEntity> repository;
  ServicesUseCases({required this.repository});

  List<ServiceEntity> _convert(List<Map<dynamic, dynamic>> entity) {
    return ServiceAdapter.servicesListDecode(entity);
  }

  @override
  Stream<List<ServiceEntity>> get(String url) {
    var services = repository.get(url);
    return services.map(_convert);
  }
}
