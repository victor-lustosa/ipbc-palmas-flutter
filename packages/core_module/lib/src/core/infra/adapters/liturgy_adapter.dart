
import 'package:core_module/core_module.dart';

class LiturgyAdapter {
  LiturgyAdapter._();

  static List<LiturgyEntity> fromMapList(dynamic json) {
    List<LiturgyEntity> liturgiesList = [];
    for (dynamic liturgy in json) {
      liturgiesList.add(
        LiturgyEntity(
          id: liturgy['id'],
          isAdditional: liturgy['is_additional'],
          sequence: liturgy['sequence'],
          additional: liturgy['additional'],
        ),
      );
    }
    return liturgiesList;
  }

  static List<Map<String, dynamic>> toMapList(List<LiturgyEntity> data) {
    return data
        .map(
          (entity) => {
            'id': entity.id,
            'is_additional': entity.isAdditional,
            'sequence': entity.sequence,
            'additional': entity.additional,
          },
        )
        .toList();
  }
}
