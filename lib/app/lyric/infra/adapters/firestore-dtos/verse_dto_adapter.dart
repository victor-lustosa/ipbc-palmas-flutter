import '../../../domain/entities/verse_entity.dart';

class VerseDTOAdapter {

  static List verseJsonDecode(dynamic json) {
    List results = [];
    for (int i = 0; i < json[0].length; i++) {
      results.add(json[0]['verse$i']);
    }
    return results;
  }

  static VerseEntity fromMap(dynamic json) {
    return VerseEntity(
      id: json['id'],
      isChorus: json['isChorus'],
      versesList: verseJsonDecode(json['versesList']),
    );
  }

  static List<VerseEntity> fromVagalume(dynamic json) {
    List<VerseEntity> verseEntityList = [];
    if (json.length > 2) {
      List versesConverted = json['mus'][0]['text'].split(RegExp(r'(\n\n)'));
      for (int i = 0; versesConverted.length > i; i++) {
        verseEntityList.add(
          VerseEntity(
            id: i,
            isChorus: false,
            versesList: versesConverted[i].split(RegExp(r'(\n)')),
          ),
        );
      }
      return verseEntityList;
    } else{
      return [];
    }
  }
}
