
import '../../../../../lyric/infra/models/dtos/liturgy_dto.dart';

class LiturgyAdapter {

  static List<Map<String, dynamic>> toMapList(List<LiturgyDTO> data) {
    return data.map((entity) => {
              'isAdditional': entity.isAdditional,
              'sequence': entity.sequence,
              'additional': entity.additional,
            }).toList();
  }
}
