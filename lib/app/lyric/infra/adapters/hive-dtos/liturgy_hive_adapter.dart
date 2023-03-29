
import '../../../domain/entities/liturgy_entity.dart';
import '../../models/hive-dtos/liturgy_hive_dto.dart';

class LiturgyHiveAdapter {

  static List<Map<String, dynamic>> toMapList(List<LiturgyHiveDTO> data) {
    return data.map((entity) => {
              'isAdditional': entity.isAdditional,
              'sequence': entity.sequence,
              'additional': entity.additional,
            }).toList();
  }
  static List<LiturgyHiveDTO> toDTOList(List<LiturgyEntity> entities) {
    List<LiturgyHiveDTO> liturgyList = [];
    for (LiturgyEntity liturgy in entities) {
      liturgyList.add(
        LiturgyHiveDTO(
          isAdditional: liturgy.isAdditional,
          sequence: liturgy.sequence,
          additional: liturgy.additional,
        ),
      );
    }
    return liturgyList;
  }
}
