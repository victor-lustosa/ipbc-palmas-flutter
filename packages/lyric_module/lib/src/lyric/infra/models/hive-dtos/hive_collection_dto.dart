import 'hive_lyric_dto.dart';
import 'hive_liturgy_dto.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'hive_collection_dto.g.dart';

@HiveType(typeId: 1)
class HiveCollectionDTO {
  @HiveField(0)
  String id;

  @HiveField(1)
  String createAt;

  @HiveField(2)
  bool guideIsVisible;

  @HiveField(3)
  String title;

  @HiveField(4)
  String heading;

  @HiveField(5)
  List<HiveLyricDTO> lyricsList;

  @HiveField(6)
  List<HiveLiturgyDTO> liturgyList;

  @HiveField(7)
  String type;

  @HiveField(8)
  String theme;

  @HiveField(9)
  String preacher;

  @HiveField(10)
  String image;

  @HiveField(11)
  String hour;

  HiveCollectionDTO({
        required this.id,
        required this.title,
        required this.image,
        required this.hour,
        required this.theme,
        required this.preacher,
        required this.type,
        required this.guideIsVisible,
        required this.heading,
        required this.liturgyList,
        required this.lyricsList,
        required this.createAt});
}
