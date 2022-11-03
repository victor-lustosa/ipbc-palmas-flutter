import 'package:ipbc_palmas/app/lyric/domain/entities/verse_entity.dart';

class LyricEntity {
  final String id;
  final String title;
  final String group;
  final List<VerseEntity> verses;

  @override
  String toString() {
    return 'LyricEntity{id: $id, title: $title, group: $group, verses: $verses}';
  }

  LyricEntity(
      {required this.id,
      required this.title,
      required this.group,
      required this.verses});
}
