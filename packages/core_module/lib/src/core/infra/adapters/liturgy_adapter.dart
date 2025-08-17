import 'package:core_module/core_module.dart';

class LiturgyAdapter {
  LiturgyAdapter._();

  static List<LiturgyEntity> fromMapList(dynamic json) {
    List<LiturgyEntity> liturgiesList = [];
    for (dynamic liturgy in json) {
      liturgiesList.add(
        LiturgyEntity(
          id: liturgy['id'],
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
          id: liturgy['id'],
          isAdditional: liturgy['isAdditional'],
          sequence: liturgy['sequence'],
          additional: liturgy['additional'],
        ),
      );
    }
    return liturgiesList;
  }

  static Map<String, dynamic> supabaseToMap(LiturgySupabase data) {
    return {'id': data.id, 'liturgy': data.liturgy};
  }

  static List<Map<String, dynamic>> toMapList(List<LiturgyEntity> data) {
    return data
        .map(
          (entity) => {
            'id': entity.id,
            'isAdditional': entity.isAdditional,
            'sequence': entity.sequence,
            'additional': entity.additional,
          },
        )
        .toList();
  }
}
