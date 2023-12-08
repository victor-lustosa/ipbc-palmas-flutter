import 'dart:convert';

import '../../../../lyric_module.dart';
// ignore: depend_on_referenced_packages

class SupaLyricAdapter {

  static List<LyricModel> fromJson(String source) => fromMapList(json.decode(source));
  static LyricModel fromUnknownJson(String source) => fromMap(json.decode(source));

  static LyricModel fromMap(dynamic json) {
    return LyricModel(
      albumCover: json['albumCover'],
      id: json['id'],
      createAt: DateTime.now(),
      title: json['title'],
      group: json['group'],
      verses: [
        if (json.containsKey('verses'))
          ...(json['verses'] as List)
              .map(VerseAdapter.fromMap)
              .toList(),
      ],
    );
  }

  static Map<String, dynamic> toMap(LyricEntity data) {
    return {
      'id': data.id,
      'title': data.title,
      'createAt': data.createAt,
      'albumCover': data.albumCover,
      'group': data.group,
      'verses': VerseAdapter.toMapList(data.verses),
    };
  }

  static List<LyricModel> fromMapList(dynamic json) {
    List<LyricModel> lyricsList = [];
    for (dynamic lyric in json) {
      lyricsList.add(
        LyricModel(
          albumCover: lyric['albumCover'],
          id: lyric['id'],
          createAt: DateTime.parse(lyric['createAt']),
          title: lyric['title'],
          group: lyric['group'],
          verses: [
            if (lyric.containsKey('verses'))
              ...(lyric['verses'] as List).map(VerseAdapter.fromMap).toList(),
          ],
        ),
      );
    }
    return lyricsList;
  }

  static List<Map<String, dynamic>> toMapList(List<LyricEntity> data) {
    return data
        .map((entity) => {
      'id': entity.id,
      'title': entity.title,
      'createAt': entity.createAt.toString(),
      'albumCover': entity.albumCover,
      'group': entity.group,
      'verses': VerseAdapter.toMapList(entity.verses),
    })
        .toList();
  }

}
