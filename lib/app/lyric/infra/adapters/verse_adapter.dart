import '../../domain/entities/verse_entity.dart';

class VerseAdapter {
  static VerseEntity fromMap(dynamic json) {
    return VerseEntity(
      id: json['id'].runtimeType == String ? int.parse(json['id']) : json['id'],
      isChorus: json['isChorus'],
      versesList: json['versesList'],
    );
  }

  static List<Map<String, dynamic>> toMapList(List<VerseEntity> data) {
    return data
        .map((entity) => {
              'id': entity.id,
              'isChorus': entity.isChorus,
              'versesList': entity.versesList,
            })
        .toList();
  }
}
