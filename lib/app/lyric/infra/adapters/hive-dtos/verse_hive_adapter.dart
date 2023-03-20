

import '../../../domain/entities/verse_entity.dart';
import '../../models/hive-dtos/verse_hive_dto.dart';

class VerseHiveAdapter {

  static List<Map<String, dynamic>> toMapList(List<VerseHiveDTO> data) {
    return data.map((entity) => {
      'id': entity.id,
      'isChorus': entity.isChorus,
      'versesList': entity.versesList,
    }).toList();
  }
  static VerseEntity fromDTO(VerseHiveDTO data) {
    return VerseEntity(
      id: int.parse(data.id),
      isChorus: data.isChorus,
      versesList: data.versesList,
    );
  }
  static VerseHiveDTO fromEntity(VerseEntity data) {
    return VerseHiveDTO(
      id: data.id.toString(),
      isChorus: data.isChorus,
      versesList: data.versesList,
    );
  }
  static List<VerseEntity> toEntityList(List<VerseHiveDTO> data) {
    return data.map((entity) =>
        VerseEntity(
          id: int.parse(entity.id),
          isChorus: entity.isChorus,
          versesList: entity.versesList, )).toList();
  }
  static List<VerseHiveDTO> toDTOList(List<VerseEntity> data) {
    return data.map((entity) =>
        VerseHiveDTO(
          id: entity.id.toString(),
          isChorus: entity.isChorus,
          versesList: entity.versesList, )).toList();
  }
}