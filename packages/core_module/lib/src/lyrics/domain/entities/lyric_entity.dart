import 'package:core_module/core_module.dart';

class LyricEntity {
  final String id;
  final String title;
  final String group;
  final String albumCover;
  final String createAt;
  final List<VerseEntity> verses;
  LyricEntity({
    required this.id,
    required this.title,
    required this.createAt,
    required this.albumCover,
    required this.group,
    required this.verses,
  });

  factory LyricEntity.empty() => LyricEntity(
    id: MockUtil.createId(),
    createAt: '',
    title: '',
    group: '',
    albumCover: '',
    verses: [],
  );

  LyricEntity copyWith({
    String? id,
    String? title,
    String? createAt,
    String? group,
    String? albumCover,
    List<VerseEntity>? verses,
  }) {
    return LyricEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      createAt: createAt ?? this.createAt,
      albumCover: albumCover ?? this.albumCover,
      group: group ?? this.group,
      verses: verses ?? this.verses,
    );
  }
}
