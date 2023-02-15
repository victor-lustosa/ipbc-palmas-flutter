import '../../../domain/entities/verse_entity.dart';

class LyricDTO {
  final String id;
  final String title;
  final String group;
  final String albumCover;
  final DateTime createAt;
  final List<VerseEntity> verses;
  LyricDTO(
      {required this.id,
      required this.title,
      required this.createAt,
      required this.albumCover,
      required this.group,
      required this.verses});

  factory LyricDTO.empty() => LyricDTO(
      id: '',
      createAt: DateTime.now(),
      title: '',
      group: '',
      albumCover: '',
      verses: []);

  LyricDTO copyWith({
    String? id,
    String? title,
    DateTime? createAt,
    String? group,
    String? albumCover,
    List<VerseEntity>? verses,
  }) {
    return LyricDTO(
      id: id ?? this.id,
      title: title ?? this.title,
      createAt: createAt ?? this.createAt,
      albumCover: albumCover ?? this.albumCover,
      group: group ?? this.group,
      verses: verses ?? this.verses,
    );
  }

  @override
  String toString() {
    return 'LyricDTO{id: $id, title: $title, group: $group, albumCover: $albumCover, createAt: $createAt, verses: $verses}';
  }
}
