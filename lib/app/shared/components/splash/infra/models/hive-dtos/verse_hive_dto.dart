import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

import '../generic_hive_dto.dart';

part 'verse_hive_dto.g.dart';
@HiveType(typeId: 2)
class VerseHiveDTO extends GenericHiveDTO {

  @HiveField(0)
  String id;

  @HiveField(1)
  bool isChorus;

  @HiveField(2)
  List versesList;

  factory VerseHiveDTO.create(
      { required bool isChorus,
        required List versesList }) =>
      VerseHiveDTO(
          id: const Uuid().v1(),
          isChorus: isChorus,
          versesList: versesList);

  VerseHiveDTO({
    required this.id,
    required this.isChorus,
    required this.versesList,
  });
}
