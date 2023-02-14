
import '../../../core/infra/repositories/repository.dart';
import '../../infra/adapters/service_adapter.dart';

import '../entities/service_entity.dart';

abstract class IServicesUseCases {
  Stream<List<ServiceEntity>> get(String url);
}

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
