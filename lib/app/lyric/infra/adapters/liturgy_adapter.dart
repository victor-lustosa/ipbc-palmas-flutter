import '../models/dtos/liturgy_dto.dart';

class LiturgyAdapter {
  static List<LiturgyDTO> fromMap(dynamic json) {
    List<LiturgyDTO> liturgyList = [];
    for (dynamic liturgy in json) {
      liturgyList.add(
        LiturgyDTO(
          isAdditional: liturgy['isAdditional'],
          sequence: liturgy['sequence'],
          additional: liturgy['additional'],
        ),
      );
    }
    return liturgyList;
  }

  static List<Map<String, dynamic>> toMap(List<LiturgyDTO> data) {
    return data.map((entity) => {
              'isAdditional': entity.isAdditional,
              'sequence': entity.sequence,
              'additional': entity.additional,
            }).toList();
  }
}
