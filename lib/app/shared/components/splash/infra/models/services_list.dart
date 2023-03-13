import 'package:ipbc_palmas/app/shared/components/splash/infra/models/hive-dtos/service_hive_dto.dart';

class ServicesList {
  const ServicesList({
    required this.servicesList,
    required this.createAt,
  });
  final String createAt;
  final List<ServiceHiveDTO> servicesList;
}
