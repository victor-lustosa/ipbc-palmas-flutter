import 'service_hive_dto.dart';

import 'package:hive/hive.dart';
part 'hive_services_list_dto.g.dart';

@HiveType(typeId: 5)
class HiveServicesListDTO {

  @HiveField(0)
  List<ServiceHiveDTO> servicesList;

  HiveServicesListDTO({required this.servicesList});
}
