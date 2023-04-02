import '../../models/hive-dtos/hive_database_configs_dto.dart';

class HiveDatabaseConfigsAdapter {
  static List<Map<String, dynamic>> toMapList(HiveDatabaseConfigsDTO data) {
    List<Map<String, dynamic>> map = [];
    map.add({'updateAt': data.updateAt});
    return map;
  }

  static HiveDatabaseConfigsDTO fromMap(List<Map> json) {
    return HiveDatabaseConfigsDTO(
      updateAt: json[0]['updateAt'],
    );
  }
}
