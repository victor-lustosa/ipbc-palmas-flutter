import 'dart:convert';

import '../../../../../core_module.dart';

// ignore: depend_on_referenced_packages

class SupaLyricAdapter {
  static List<LyricModel> fromJson(String source) =>
      fromMapList(json.decode(source));
  static LyricModel fromUnknownJson(String source) =>
      fromMap(json.decode(source));

  static LyricModel fromMap(dynamic json) {
    return LyricModel(
      albumCover: json['albumCover'],
      id: json['id'],
      createAt: '',
      title: json['title'],
      group: json['group'],
      verses: [
        if (json.containsKey('verses'))
          ...(json['verses'] as List).map(VerseAdapter.fromMap),
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
          albumCover: lyric['lyrics']['albumCover'],
          id: lyric['lyrics']['id'].toString(),
          createAt: DateFormat("dd/MM/yyyy").format(DateTime.parse(lyric['lyrics']['createAt'])),
          title: lyric['lyrics']['title'],
          group: lyric['lyrics']['group'],
          verses: [
            if (lyric['lyrics'].containsKey('verses'))
              ...(lyric['lyrics']['verses'] as List).map(VerseAdapter.fromMap),
          ],
        ),
      );
    }
    return lyricsList;
  }

  static List<Map<String, dynamic>> toMapList(List<LyricEntity> data) {
    return data
        .map(
          (entity) => {
            'id': entity.id,
            'title': entity.title,
            'createAt': entity.createAt.toString(),
            'albumCover': entity.albumCover,
            'group': entity.group,
            'verses': VerseAdapter.toMapList(entity.verses),
          },
        )
        .toList();
  }
}
