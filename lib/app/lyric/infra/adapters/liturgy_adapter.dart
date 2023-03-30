import '../../domain/entities/liturgy_entity.dart';

class LiturgyAdapter {
  static List<LiturgyEntity> fromMap(dynamic json) {
    List<LiturgyEntity> liturgyList = [];
    for (dynamic liturgy in json) {
      liturgyList.add(
        LiturgyEntity(
          isAdditional: liturgy['isAdditional'],
          sequence: liturgy['sequence'],
          additional: liturgy['additional'],
        ),
      );
    }
    return liturgyList;
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
