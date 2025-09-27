
import 'package:core_module/core_module.dart';

class VerseAdapter {
  VerseAdapter._();
  static List<VerseEntity> fromMapList(dynamic json) {
    List<VerseEntity> versesList = [];
    for (dynamic verse in json) {
      versesList.add(
          VerseEntity(
            id: verse['id'].runtimeType == String ? int.parse(verse['id']) : verse['id'],
            isChorus: verse['is_chorus'],
            versesList:
            verse['verses_list'].runtimeType == String
                ? verseJsonDecode(verse['verses_list'])
                : verseSupaDecode(verse['verses_list']),
          )
      );
    }
    return versesList;
  }
  static List<String> verseSupaDecode(dynamic json) {
    List<String> results = [];
    for (int i = 0; i < json.length; i++) {
      results.add(json['$i']);
    }
    return results;
  }
  static Map<String, dynamic> verseSupaEncode(List<String> versesList) {
    Map<String, dynamic> map = {};
    for (int i = 0; i < versesList.length; i++) {
      map.addAll({'$i': versesList[i]});
    }
    return map;
  }
  static List<String> verseJsonDecode(dynamic json) {
    List<String> results = [];
    for (int i = 0; i < json[0].length; i++) {
      results.add(json[0]['verse$i']);
    }
    return results;
  }

  static List<Map<String, dynamic>> toMapList(List<VerseEntity> data) {
    return data
        .map(
          (entity) => {
            'id': entity.id,
            'is_chorus': entity.isChorus,
            'verses_list': verseSupaEncode(entity.versesList),
          },
        )
        .toList();
  }
}
