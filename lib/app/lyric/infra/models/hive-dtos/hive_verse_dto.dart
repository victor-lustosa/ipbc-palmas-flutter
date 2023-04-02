import 'package:hive/hive.dart';
part 'hive_verse_dto.g.dart';

@HiveType(typeId: 2)
class HiveVerseDTO {
  @HiveField(0)
  String id;

  @HiveField(1)
  bool isChorus;

  @HiveField(2)
  List versesList;

  HiveVerseDTO({
    required this.id,
    required this.isChorus,
    required this.versesList,
  });
}
