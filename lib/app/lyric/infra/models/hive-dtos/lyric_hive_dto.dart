import 'package:hive/hive.dart';
import 'verse_hive_dto.dart';
part 'lyric_hive_dto.g.dart';

@HiveType(typeId: 0)
class LyricHiveDTO {
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
  List<VerseHiveDTO> verses;

  LyricHiveDTO({
    required this.albumCover,
    required this.title,
    required this.createAt,
    required this.group,
    required this.verses,
    required this.id,
  });
}
