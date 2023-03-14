

import 'package:ipbc_palmas/app/shared/components/splash/infra/models/hive-dtos/lyric_hive_dto.dart';
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';

import '../../../../../../lyric/infra/models/dtos/liturgy_dto.dart';

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

  factory ServiceHiveDTO.create(
          {required String title,
          required bool guideIsVisible,
          required String heading,
          required String createAt,
          required List<LyricHiveDTO> lyricsList,
          required List<LiturgyDTO> liturgyList}) =>
      ServiceHiveDTO(
          id: const Uuid().v1(),
          title: title,
          guideIsVisible: guideIsVisible,
          heading: heading,
          createAt: createAt,
          lyricsList: lyricsList,
          liturgyList: liturgyList);
  ServiceHiveDTO(
      {required this.id,
      required this.title,
      required this.guideIsVisible,
      required this.heading,
      required this.liturgyList,
      required this.lyricsList,
      required this.createAt});
}
