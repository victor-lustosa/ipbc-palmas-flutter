import '../../../../service_module.dart';

class HiveLiturgyAdapter {
  static List<Map<String, dynamic>> toMapList(List<HiveLiturgyDTO> data) {
    return data
        .map((entity) => {
              'isAdditional': entity.isAdditional,
              'sequence': entity.sequence,
              'additional': entity.additional,
            })
        .toList();
  }

  static List<HiveLiturgyDTO> toDTOList(List<LiturgyEntity> entities) {
    List<HiveLiturgyDTO> liturgyList = [];
    for (LiturgyEntity liturgy in entities) {
      liturgyList.add(
        HiveLiturgyDTO(
          isAdditional: liturgy.isAdditional,
          sequence: liturgy.sequence,
          additional: liturgy.additional,
        ),
      );
    }
    return liturgyList;
  }
}
