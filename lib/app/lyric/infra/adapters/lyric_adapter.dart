import 'dart:math';

import 'package:ipbc_palmas/app/shared/configs/app_configs.dart';

import '../../infra/adapters/verse_adapter.dart';
import '../../domain/entities/lyric_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat;

class LyricAdapter {

  static LyricEntity fromMap(Map<dynamic, dynamic> json) {

    return LyricEntity(
      albumCover: json['albumCover'],
      id: json['id'],
      createAt: json['createAt'] == ''
          ? ''
          : DateFormat('dd/MM/yyyy, HH:mm')
              .format((json['createAt'] as Timestamp).toDate()),
      title: json['title'],
      group: json['group'],
      verses: [
        if (json.containsKey('verses'))
          //...(json['verses'] as List).map((verse) => JsonToVerse.fromMap(verse)).toList(),
          ...(json['verses'] as List).map(VerseAdapter.fromMap).toList(),
      ],
    );
  }

  static List<LyricEntity> fromListMap(dynamic json) {

    List<LyricEntity> lyricsList = [];
    for (dynamic lyric in json) {
      lyricsList.add(
        LyricEntity(
          albumCover: lyric['albumCover'],
          id: lyric['id'],
          createAt: lyric['createAt'] == ''
              ? ''
              : DateFormat('dd/MM/yyyy, HH:mm')
                  .format((lyric['createAt'] as Timestamp).toDate()),
          title: lyric['title'],
          group: lyric['group'],
          verses: [
            if (lyric.containsKey('verses'))
              //...(json['verses'] as List).map((verse) => JsonToVerse.fromMap(verse)).toList(),
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
