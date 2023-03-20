
import 'package:ipbc_palmas/app/shared/components/splash/infra/models/hive-dtos/database_configs_hive_dto.dart';

class DatabaseConfigsHiveAdapter {

  static List<Map<String, dynamic>> toMapList(DatabaseConfigsHiveDTO data) {
    List<Map<String, dynamic>> map = [];
    map.add({'updateAt': data.updateAt});
    return map;
  }
  static DatabaseConfigsHiveDTO fromMap(List<Map<dynamic, dynamic>> json) {
    return DatabaseConfigsHiveDTO(
      updateAt: json[0]['updateAt'],
    );
  }
}
