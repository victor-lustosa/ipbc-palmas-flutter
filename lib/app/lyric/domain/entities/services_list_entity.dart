import 'service_entity.dart';

class ServicesListEntity {
  const ServicesListEntity({
    required this.servicesList,
    required this.createAt,
  });
  final String createAt;
  final List<ServiceEntity> servicesList;
}
