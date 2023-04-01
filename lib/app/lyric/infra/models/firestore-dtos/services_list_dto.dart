import '../../../domain/entities/service_entity.dart';

class ServicesListDTO {
  const ServicesListDTO({
    required this.servicesList,
  });
  final List<ServiceEntity> servicesList;
}
