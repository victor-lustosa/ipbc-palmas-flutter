import '../../domain/entities/service_entity.dart';

class ServicesList {
  const ServicesList({
    required this.servicesList,
    required this.createAt,
  });
  final String createAt;
  final List<ServiceEntity> servicesList;
}
