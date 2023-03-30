import '../../../domain/entities/verse_entity.dart';
import '../../models/hive-dtos/verse_hive_dto.dart';

class VerseHiveAdapter {
  static List<Map<String, dynamic>> toMapList(List<VerseHiveDTO> data) {
    return data
        .map((entity) => {
              'id': entity.id,
              'isChorus': entity.isChorus,
              'versesList': entity.versesList,
            })
        .toList();
  }

  static VerseHiveDTO toDTO(VerseEntity data) {
    return VerseHiveDTO(
      id: data.id.toString(),
      isChorus: data.isChorus,
      versesList: data.versesList,
    );
  }
}
