import 'lyric_entity.dart';
import '../../infra/models/dtos/liturgy_dto.dart';

class ServiceEntity {
  ServiceEntity(
      {required this.title,
      required this.guideIsVisible,
      required this.heading,
      required this.liturgyList,
      required this.lyricsList,
      required this.createAt});
  final String createAt;
  final bool guideIsVisible;
  final String title;
  final String heading;
  final List<LyricEntity> lyricsList;
  final List<LiturgyDTO> liturgyList;
}
