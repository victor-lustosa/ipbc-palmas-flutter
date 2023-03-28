import '../../../domain/entities/service_entity.dart';

class ServicesListDTO {
  const ServicesListDTO({
    required this.servicesList,
    required this.createAt,
  });
  final String createAt;
  final List<ServiceEntity> servicesList;
}
