// ignore_for_file: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'package:ipbc_palmas/app/lyric/infra/converts/json_to_verse.dart';

import '../../domain/entities/lyric_entity.dart';
import '../../domain/entities/verse_entity.dart';

class LyricModel extends LyricEntity {
  LyricModel(
      {required String id,
      required String title,
      required String createAt,
      required String albumCover,
      required String group,
      required List<VerseEntity> verses})
      : super(
            id: id,
            title: title,
            createAt: createAt,
            group: group,
            verses: verses,
            albumCover: albumCover);

  factory LyricModel.empty() => LyricModel(
      id: '', createAt: '', title: '', group: '', albumCover: '', verses: []);

  LyricModel copyWith({
    String? id,
    String? title,
    String? createAt,
    String? group,
    String? albumCover,
    List<VerseEntity>? verses,
  }) {
    return LyricModel(
      id: id ?? this.id,
      title: title ?? this.title,
      createAt: createAt ?? this.createAt,
      albumCover: albumCover ?? this.albumCover,
      group: group ?? this.group,
      verses: verses ?? this.verses,
    );
  }

  static LyricEntity fromMap(dynamic json) {
    return LyricEntity(
      albumCover: json['albumCover'],
      id: json['id'],
      createAt: DateFormat('dd/MM/yyyy, HH:mm')
          .format((json['createAt'] as Timestamp).toDate()),
      title: json['title'],
      group: json['group'],
      verses: [
        if (json.containsKey('verses'))
          //...(json['verses'] as List).map((verse) => JsonToVerse.fromMap(verse)).toList(),
          ...(json['verses'] as List).map(JsonToVerse.fromMap).toList(),
      ],
    );
  }
}
