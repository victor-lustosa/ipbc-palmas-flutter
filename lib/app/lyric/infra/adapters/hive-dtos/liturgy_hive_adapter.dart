
import '../../models/hive-dtos/liturgy_hive_dto.dart';

class LiturgyHiveAdapter {

  static List<Map<String, dynamic>> toMapList(List<LiturgyHiveDTO> data) {
    return data.map((entity) => {
              'isAdditional': entity.isAdditional,
              'sequence': entity.sequence,
              'additional': entity.additional,
            }).toList();
  }
}
