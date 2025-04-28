import 'dart:convert';

import '../../../../core_module.dart';
import '../../../shared/mixins/flatten_mixin.dart';

// ignore: depend_on_referenced_packages

class LyricAdapter with FlattenMixin{
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
      verses:
          (json.containsKey('verses'))
              ? VerseAdapter.fromMapList(json['verses'])
              : [],
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
          id: lyric['id'].toString(),
          createAt: DateFormat(
            "dd/MM/yyyy",
          ).format(DateTime.parse(lyric['createAt'])),
          title: lyric['title'],
          group: lyric['group'],
          verses:
              (lyric['lyrics_verses'].isNotEmpty)
                  ? VerseAdapter.fromMapList(FlattenMixin.flattenByKey(lyric['lyrics_verses'],'verses'))
                  : [],
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
