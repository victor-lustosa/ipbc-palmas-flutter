import 'package:hive/hive.dart';

import 'hive_liturgy_dto.dart';
import 'hive_lyric_dto.dart';
part 'hive_service_dto.g.dart';

@HiveType(typeId: 1)
class HiveServiceDTO {
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
  String? type;

  HiveServiceDTO(
      {required this.id,
      required this.title,
      required this.type,
      required this.guideIsVisible,
      required this.heading,
      required this.liturgyList,
      required this.lyricsList,
      required this.createAt});
}
