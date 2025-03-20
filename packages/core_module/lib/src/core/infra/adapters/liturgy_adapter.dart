import 'package:core_module/core_module.dart';

class LiturgyAdapter {
  static List<LiturgyEntity> fromMapList(dynamic json) {
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

  static List<LiturgyEntity> supaMapList(dynamic json) {
    List<LiturgyEntity> liturgiesList = [];
    for (dynamic liturgy in json) {
      liturgiesList.add(
        LiturgyEntity(
          isAdditional: liturgy['liturgies']['isAdditional'],
          sequence: liturgy['liturgies']['sequence'],
          additional: liturgy['liturgies']['additional'],
        ),
      );
    }
    return liturgiesList;
  }

  static List<Map<String, dynamic>> toMapList(List<LiturgyEntity> data) {
    return data
        .map(
          (entity) => {
            'isAdditional': entity.isAdditional,
            'sequence': entity.sequence,
            'additional': entity.additional,
          },
        )
        .toList();
  }
}
