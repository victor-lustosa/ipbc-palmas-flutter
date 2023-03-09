
import '../entities/service_entity.dart';

abstract class IServicesUseCases {
  Stream<List<ServiceEntity>> get(String url);
}

