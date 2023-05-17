import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../verse_adapter.dart';
import '../firestore-dtos/verse_dto_adapter.dart';
import '../../models/firestore-dtos/lyric_dto.dart';

class LyricDTOAdapter {
  static List<LyricDTO> fromJson(String source) => fromMap(json.decode(source));

  static List<LyricDTO> fromMap(dynamic json) {
    List<LyricDTO> lyricList = [];
    for (dynamic lyric in json) {
      lyricList.add(
        LyricDTO(
          albumCover: lyric['albumCover'],
          id: lyric['id'],
          createAt: Timestamp.now().toDate(),
          title: lyric['title'],
          group: lyric['group'],
          verses: [
            if (lyric.containsKey('verses'))
              ...(lyric['verses'] as List)
                  .map(VerseDTOAdapter.fromMap)
                  .toList(),
          ],
        ),
      );
    }
    return lyricList;
  }

  static Map<String, dynamic> toMap(LyricDTO data) {
    return {
      'id': data.id,
      'title': data.title,
      'createAt': data.createAt,
      'albumCover': data.albumCover,
      'group': data.group,
      'verses': VerseAdapter.toMapList(data.verses),
    };
  }

  static List<Map<String, dynamic>> toMapList(List<LyricDTO> data) {
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
