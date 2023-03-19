
import '../../../../splash/infra/models/hive-dtos/verse_hive_dto.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

import '../generic_hive_dto.dart';

part 'lyric_hive_dto.g.dart';
@HiveType(typeId: 0)
class LyricHiveDTO extends GenericHiveDTO{
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

  factory LyricHiveDTO.create(
          {required String albumCover,
          required String title,
          required String createAt,
          required String group,
          required List<VerseHiveDTO> verses}) =>
      LyricHiveDTO(
          albumCover: albumCover,
          id: const Uuid().v1(),
          title: title,
          createAt: createAt,
          group: group,
          verses: verses);

  LyricHiveDTO({
    required this.albumCover,
    required this.title,
    required this.createAt,
    required this.group,
    required this.verses,
    required this.id,
  });
}