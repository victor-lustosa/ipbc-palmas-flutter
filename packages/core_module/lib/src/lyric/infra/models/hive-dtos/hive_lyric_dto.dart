import 'package:hive/hive.dart';

import 'hive_verse_dto.dart';
part 'hive_lyric_dto.g.dart';

@HiveType(typeId: 0)
class HiveLyricDTO {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String group;

  @HiveField(3)
  String albumCover;

  @HiveField(4)
  String createAt;

  @HiveField(5)
  List<HiveVerseDTO> verses;

  HiveLyricDTO({
    required this.albumCover,
    required this.title,
    required this.createAt,
    required this.group,
    required this.verses,
    required this.id,
  });
}
