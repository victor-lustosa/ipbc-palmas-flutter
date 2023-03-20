
import 'service_hive_dto.dart';

import 'package:hive/hive.dart';
part 'services_list_hive_dto.g.dart';

@HiveType(typeId: 5)
class ServicesListHiveDTO {
  @HiveField(0)
  String createAt;

  @HiveField(1)
  List<ServiceHiveDTO> servicesList;

  ServicesListHiveDTO(
      {required this.servicesList,
      required this.createAt});
}
