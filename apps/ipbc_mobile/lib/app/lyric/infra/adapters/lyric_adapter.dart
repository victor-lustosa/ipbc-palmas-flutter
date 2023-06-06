import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/lyric_model.dart';
import '../../infra/adapters/verse_adapter.dart';
import '../../domain/entities/lyric_entity.dart';
// ignore: depend_on_referenced_packages

class LyricAdapter {

  static List<LyricModel> fromJson(String source) => fromMapList(json.decode(source));
  static LyricModel fromUnknownJson(String source) => fromMap(json.decode(source));

  static LyricModel fromMap(dynamic json) {
    return LyricModel(
      albumCover: json['albumCover'],
      id: json['id'],
      createAt: Timestamp.now().toDate(),
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
          createAt: lyric['createAt'].runtimeType == String
              ? DateTime.parse(lyric['createAt'])
              : (lyric['createAt'] as Timestamp).toDate(),
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
      'createAt': entity.createAt,
      'albumCover': entity.albumCover,
      'group': entity.group,
      'verses': VerseAdapter.toMapList(entity.verses),
    })
        .toList();
  }

}
