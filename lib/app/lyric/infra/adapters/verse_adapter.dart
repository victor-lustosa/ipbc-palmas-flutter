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
  static List<VerseEntity> fromVagalume(dynamic json) {
    List<VerseEntity> verseEntityList = [];
    if (json.length > 2) {
      List<String> versesResult =
      json['mus'][0]['text'].split(RegExp(r'(\n\n)'));
      for (int i = 0; versesResult.length > i; i++) {
        List<String> versesConverted = versesResult[i].split(RegExp(r'(\n)'));
        versesConverted.retainWhere((verse) {
          return verse.isNotEmpty;
        });
        verseEntityList.add(
          VerseEntity(
            id: i,
            isChorus: false,
            versesList: versesConverted,
          ),
        );
      }
      return verseEntityList;
    } else {
      return [];
    }
  }
}
