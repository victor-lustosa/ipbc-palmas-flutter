import 'verse_entity.dart';

class LyricEntity {
  final int id;
  final String title;
  final String group;
  final String albumCover;
  final DateTime createAt;
  final List<VerseEntity> verses;
  LyricEntity({
      required this.id,
      required this.title,
      required this.createAt,
      required this.albumCover,
      required this.group,
      required this.verses});
}
