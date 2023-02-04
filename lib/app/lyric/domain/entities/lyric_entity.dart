import 'package:ipbc_palmas/app/lyric/domain/entities/verse_entity.dart';

class LyricEntity {
  final String id;
  final String title;
  final String group;
  final String albumCover;
  final String createAt;
  final List<VerseEntity> verses;

  LyricEntity(
      {required this.albumCover,
      required this.id,
      required this.title,
      required this.createAt,
      required this.group,
      required this.verses});
}
