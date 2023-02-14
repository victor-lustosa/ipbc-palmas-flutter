// ignore_for_file: depend_on_referenced_packages

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
          albumCover: albumCover,
        );

  factory LyricModel.empty() => LyricModel(
        id: '',
        createAt: '',
        title: '',
        group: '',
        albumCover: '',
        verses: [],
      );

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
}
