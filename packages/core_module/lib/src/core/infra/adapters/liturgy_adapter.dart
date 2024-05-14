
import 'package:core_module/core_module.dart';

class LiturgyAdapter {
  static List<LiturgyEntity> fromMap(dynamic json) {
    List<LiturgyEntity> liturgiesList = [];
    for (dynamic liturgy in json) {
      liturgiesList.add(
        LiturgyEntity(
          isAdditional: liturgy['isAdditional'],
          sequence: liturgy['sequence'],
          additional: liturgy['additional'],
        ),
      );
    }
    return liturgiesList;
  }

  static List<Map<String, dynamic>> toMapList(List<LiturgyEntity> data) {
    return data
        .map((entity) => {
              'isAdditional': entity.isAdditional,
              'sequence': entity.sequence,
              'additional': entity.additional,
            })
        .toList();
  }
}
