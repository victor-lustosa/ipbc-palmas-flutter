import 'dart:convert';

import '../../../../core_module.dart';
import '../../../shared/mixins/flatten_mixin.dart';

// ignore: depend_on_referenced_packages

class LyricAdapter with FlattenMixin{
  LyricAdapter._();
  static List<LyricEntity> fromJson(String source) =>
      fromMapList(json.decode(source));

  static LyricEntity fromUnknownJson(String source) =>
      fromMap(json.decode(source));

  static LyricEntity fromMap(dynamic json) {
    return LyricEntity(
      albumCover: json['album_cover'],
      id: json['id'],
      createAt: '',
      title: json['title'],
      artist: json['artist'],
      isHymn: json['is_hymn'],
      verses:
          (json.containsKey('verses'))
              ? VerseAdapter.fromMapList(json['verses'])
              : [],
    );
  }

  static Map<String, dynamic> toMap(LyricEntity data) {
    return {
      if (data.id != null) 'id': data.id,
      'title': data.title,
      'create_at': data.createAt,
      'album_cover': data.albumCover,
      'artist': data.artist,
      'is_hymn': data.isHymn,
      'verses': VerseAdapter.toMapList(data.verses),
    };
  }

  static List<LyricEntity> fromMapList(dynamic json) {
    List<LyricEntity> lyricsList = [];
    for (dynamic lyric in json) {
      lyricsList.add(
        LyricEntity(
          albumCover: lyric['album_cover'],
          id: lyric['id'].toString(),
          createAt: lyric['create_at'].runtimeType == String ? lyric['create_at'] : DateFormat(
            "dd/MM/yyyy",
          ).format(DateTime.parse(lyric['create_at'])),
          title: lyric['title'],
          artist: lyric['artist'],
          isHymn: lyric['is_hymn'],
          verses:
              (lyric['verses'] != null)
                  ? VerseAdapter.fromMapList(lyric['verses'])
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
            if (entity.id != null) 'id': entity.id,
            'title': entity.title,
            'create_at': entity.createAt.toString(),
            'album_cover': entity.albumCover,
            'artist': entity.artist,
            'verses': VerseAdapter.toMapList(entity.verses),
            'is_hymn': entity.isHymn,
          },
        )
        .toList();
  }
}
