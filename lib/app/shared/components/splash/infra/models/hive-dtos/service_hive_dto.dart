
import '../../../../../../shared/components/splash/infra/models/hive-dtos/lyric_hive_dto.dart';
import '../../../../../../lyric/infra/models/dtos/liturgy_dto.dart';

import 'package:hive/hive.dart';
part 'service_hive_dto.g.dart';

@HiveType(typeId: 1)
class ServiceHiveDTO {
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
  List<LyricHiveDTO> lyricsList;

  @HiveField(6)
  List<LiturgyDTO> liturgyList;

  ServiceHiveDTO(
      {required this.id,
      required this.title,
      required this.guideIsVisible,
      required this.heading,
      required this.liturgyList,
      required this.lyricsList,
      required this.createAt});
}
