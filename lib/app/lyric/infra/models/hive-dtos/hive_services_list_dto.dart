import 'hive_service_dto.dart';

import 'package:hive/hive.dart';
part 'hive_services_list_dto.g.dart';

@HiveType(typeId: 5)
class HiveServicesListDTO {

  @HiveField(0)
  List<HiveServiceDTO> servicesList;

  @HiveField(1)
  String type;

  HiveServicesListDTO(
      { required this.servicesList,
        required this.type
      });
}