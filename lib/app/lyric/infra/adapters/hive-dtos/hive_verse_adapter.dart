import '../../../domain/entities/verse_entity.dart';
import '../../models/hive-dtos/hive_verse_dto.dart';

class HiveVerseAdapter {
  static List<Map<String, dynamic>> toMapList(List<HiveVerseDTO> data) {
    return data
        .map((entity) => {
              'id': entity.id,
              'isChorus': entity.isChorus,
              'versesList': entity.versesList,
            })
        .toList();
  }

  static HiveVerseDTO toDTO(VerseEntity data) {
    return HiveVerseDTO(
      id: data.id.toString(),
      isChorus: data.isChorus,
      versesList: data.versesList,
    );
  }
}
