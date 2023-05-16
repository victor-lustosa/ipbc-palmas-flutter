import '../../infra/adapters/verse_adapter.dart';
import '../../domain/entities/lyric_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' show DateFormat;

class LyricAdapter {
  static List<LyricEntity> fromListMap(dynamic json) {
    List<LyricEntity> lyricsList = [];
    for (dynamic lyric in json) {
      lyricsList.add(
        LyricEntity(
          albumCover: lyric['albumCover'],
          id: lyric['id'],
          createAt: lyric['createAt'].runtimeType == String
              ? lyric['createAt']
              : DateFormat('dd/MM/yyyy, HH:mm')
                  .format((lyric['createAt'] as Timestamp).toDate()),
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
}
