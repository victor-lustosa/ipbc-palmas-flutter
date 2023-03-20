
import '../../../../../lyric/domain/entities/lyric_entity.dart';
import '../../infra/adapters/verse_adapter.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat;

import '../models/hive-dtos/lyric_hive_dto.dart';

class LyricHiveAdapter {

  static LyricEntity fromDTO(LyricHiveDTO lyric) {

    return LyricEntity(
      albumCover: lyric.albumCover,
      id: lyric.id,
      createAt: lyric.createAt == ''
          ? ''
          : DateFormat('dd/MM/yyyy, HH:mm')
              .format((lyric.createAt as Timestamp).toDate()),
      title: lyric.title,
      group: lyric.group,
      verses: [
        if (lyric.verses.isNotEmpty)
          //...(json['verses'] as List).map((verse) => JsonToVerse.fromMap(verse)).toList(),
          ...lyric.verses.map(VerseAdapter.fromDTO).toList(),
      ],
    );
  }
  static List<Map<String, dynamic>> toMapList(List<LyricHiveDTO> data) {
    return data
        .map((entity) => {
      'id': entity.id,
      'title': entity.title,
      'createAt': entity.createAt,
      'albumCover': entity.albumCover,
      'group': entity.group,
      'verses': VerseAdapter.toMapList(entity.verses),
    }).toList();
  }
  static LyricHiveDTO fromEntity(LyricEntity lyric) {

    return LyricHiveDTO(
      albumCover: lyric.albumCover,
      id: lyric.id,
      createAt: lyric.createAt == ''
          ? ''
          : DateFormat('dd/MM/yyyy, HH:mm')
          .format((lyric.createAt as Timestamp).toDate()),
      title: lyric.title,
      group: lyric.group,
      verses: [
        if (lyric.verses.isNotEmpty)
        //...(json['verses'] as List).map((verse) => JsonToVerse.fromMap(verse)).toList(),
          ...lyric.verses.map(VerseAdapter.fromEntity).toList(),
      ],
    );
  }

}
