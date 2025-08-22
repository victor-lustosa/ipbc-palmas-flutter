
import 'dart:convert';

import 'package:core_module/core_module.dart';

class VerseAdapter {
  VerseAdapter._();
  static List<VerseEntity> fromMapList(dynamic json) {
    List<VerseEntity> versesList = [];
    for (dynamic verse in json) {
      versesList.add(
          VerseEntity(
            id: verse['id'].runtimeType == String ? int.parse(verse['id']) : verse['id'],
            isChorus: verse['isChorus'],
            versesList:
            verse['versesList'].runtimeType == String
                ? verseJsonDecode(verse['versesList'])
                : verseSupaDecode(verse['versesList']),
          )
      );
    }
    return versesList;
  }
  static List verseSupaDecode(dynamic json) {
    final Map<String, dynamic> decoded = jsonDecode(json[0]);
    final List<String> results = decoded.values.map((e) => e.toString()).toList();
    return results;
  }

  static List verseJsonDecode(dynamic json) {
    List results = [];
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
            'isChorus': entity.isChorus,
            'versesList': entity.versesList,
          },
        )
        .toList();
  }
}
