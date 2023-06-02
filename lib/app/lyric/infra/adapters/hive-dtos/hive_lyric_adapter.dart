import 'hive_verse_adapter.dart';
import '../../models/hive-dtos/hive_lyric_dto.dart';
import '../../../domain/entities/lyric_entity.dart';

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
          createAt: lyric.createAt.toString(),
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

  static Map<String, dynamic> toMap(HiveLyricDTO data) {
    return {
      'id': data.id,
      'title': data.title,
      'createAt': data.createAt,
      'albumCover': data.albumCover,
      'group': data.group,
      'verses': HiveVerseAdapter.toMapList(data.verses),
    };
  }

  static HiveLyricDTO toDTO(LyricEntity entity) {
    return HiveLyricDTO(
      albumCover: entity.albumCover,
      id: entity.id,
      createAt: entity.createAt.toString(),
      title: entity.title,
      group: entity.group,
      verses: [
        if (entity.verses.isNotEmpty)
          ...entity.verses.map(HiveVerseAdapter.toDTO).toList(),
      ],
    );
  }
}
