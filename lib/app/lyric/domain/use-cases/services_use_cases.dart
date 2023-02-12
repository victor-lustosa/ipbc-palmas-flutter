import 'package:ipbc_palmas/app/lyric/infra/adapters/lyric_adapter.dart';

import '../../../core/infra/repositories/repository.dart';
import '../../infra/adapters/service_adapter.dart';
import '../entities/lyric_entity.dart';
import '../entities/service_entity.dart';

abstract class IServicesUseCases {
  Stream<ServiceEntity> get(String url);

}

class ServicesUseCases implements IServicesUseCases {
  final IRepository<ServiceEntity> repository;
  ServicesUseCases({required this.repository});

  ServiceEntity _convert(dynamic entity) {
    return ServiceAdapter.fromMap(entity);
  }

  @override
  Stream<ServiceEntity> get(String url) {
    var services = repository.get(url);
    return services.map(_convert);
  }

}
