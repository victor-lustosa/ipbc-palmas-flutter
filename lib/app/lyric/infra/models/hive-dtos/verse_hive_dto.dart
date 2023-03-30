import 'package:hive/hive.dart';
part 'verse_hive_dto.g.dart';

@HiveType(typeId: 2)
class VerseHiveDTO {
  @HiveField(0)
  String id;

  @HiveField(1)
  bool isChorus;

  @HiveField(2)
  List versesList;

  VerseHiveDTO({
    required this.id,
    required this.isChorus,
    required this.versesList,
  });
}
