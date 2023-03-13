
import '../models/hive-dtos/verse_hive_dto.dart';

class VerseAdapter {

  static VerseHiveDTO fromMap(dynamic json) {
    return VerseHiveDTO.create(
      isChorus: json['isChorus'],
      versesList: json['versesList'],
    );
  }

  static List<Map<String, dynamic>> toMapList(List<VerseHiveDTO> data) {
    return data.map((entity) => {
      'isChorus': entity.isChorus,
      'versesList': entity.versesList,
    }).toList();
  }
}