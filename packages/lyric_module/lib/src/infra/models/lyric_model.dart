// ignore_for_file: depend_on_referenced_packages

import '../../../lyric_module.dart';

class LyricModel extends LyricEntity {
  LyricModel(
      {required int id,
      required String title,
      required DateTime createAt,
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
        id: SupaServicesUtil.createId(),
        createAt: DateTime.now(),
        title: '',
        group: '',
        albumCover: '',
        verses: [],
      );

  LyricModel copyWith({
    int? id,
    String? title,
    DateTime? createAt,
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
