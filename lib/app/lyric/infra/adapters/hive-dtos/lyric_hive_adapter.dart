
import '../../../domain/entities/lyric_entity.dart';
import 'verse_hive_adapter.dart';
import '../../models/hive-dtos/lyric_hive_dto.dart';

class LyricHiveAdapter {

  static List<Map<String, dynamic>> toMapList(List<LyricHiveDTO> data) {
    return data
        .map((entity) => {
      'id': entity.id,
      'title': entity.title,
      'createAt': entity.createAt,
      'albumCover': entity.albumCover,
      'group': entity.group,
      'verses': VerseHiveAdapter.toMapList(entity.verses),
    }).toList();
  }

  static List<LyricHiveDTO> toDTOList(List<LyricEntity> entities) {
    List<LyricHiveDTO> lyricsList = [];
    for (LyricEntity lyric in entities) {
      lyricsList.add(
        LyricHiveDTO(
          albumCover: lyric.albumCover,
          id: lyric.id,
          createAt: lyric.createAt,
          title: lyric.title,
          group: lyric.group,
          verses: [
            if (lyric.verses.isNotEmpty)
              ...lyric.verses.map(VerseHiveAdapter.toDTO).toList(),
          ],
        ),
      );
    }
    return lyricsList;
  }

}
