
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
            'is_chorus': entity.isChorus,
            'verses_list': entity.versesList,
          },
        )
        .toList();
  }
}
