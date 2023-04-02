import '../../../infra/models/hive-dtos/hive_lyrics_list_dto.dart';
import '../../../domain/entities/lyric_entity.dart';
import 'hive_verse_adapter.dart';
import '../../models/hive-dtos/hive_lyric_dto.dart';

class HiveLyricAdapter {
  static List<Map<String, dynamic>> toMapList(List<HiveLyricDTO> data) {
    return data
        .map((entity) => {
              'id': entity.id,
              'title': entity.title,
              'createAt': entity.createAt,
              'albumCover': entity.albumCover,
              'group': entity.group,
              'verses': HiveVerseAdapter.toMapList(entity.verses),
            })
        .toList();
  }

  static List<HiveLyricDTO> toDTOList(List<LyricEntity> entities) {
    List<HiveLyricDTO> lyricsList = [];
    for (LyricEntity lyric in entities) {
      lyricsList.add(
        HiveLyricDTO(
          albumCover: lyric.albumCover,
          id: lyric.id,
          createAt: lyric.createAt,
          title: lyric.title,
          group: lyric.group,
          verses: [
            if (lyric.verses.isNotEmpty)
              ...lyric.verses.map(HiveVerseAdapter.toDTO).toList(),
          ],
        ),
      );
    }
    return lyricsList;
  }

  static List<Map<String, dynamic>> toHiveLyricsMapList(HiveLyricsListDTO data) {
    return data.lyricsList
        .map((entity) => {
              'id': entity.id,
              'title': entity.title,
              'createAt': entity.createAt,
              'albumCover': entity.albumCover,
              'group': entity.group,
              'verses': HiveVerseAdapter.toMapList(entity.verses),
            })
        .toList();
  }

  static HiveLyricsListDTO toHiveLyricsList(List<LyricEntity> entities) {
    List<HiveLyricDTO> lyricsList = [];
    for (LyricEntity lyric in entities) {
      lyricsList.add(
        HiveLyricDTO(
          albumCover: lyric.albumCover,
          id: lyric.id,
          createAt: lyric.createAt,
          title: lyric.title,
          group: lyric.group,
          verses: [
            if (lyric.verses.isNotEmpty)
              ...lyric.verses.map(HiveVerseAdapter.toDTO).toList(),
          ],
        ),
      );
    }
    return HiveLyricsListDTO(lyricsList: lyricsList);
  }
}
