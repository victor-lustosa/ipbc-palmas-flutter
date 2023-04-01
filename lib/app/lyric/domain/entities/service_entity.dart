import 'lyric_entity.dart';
import 'liturgy_entity.dart';

class ServiceEntity {
  ServiceEntity(
      {required this.theme,
      required this.preacher,
      required this.title,
      required this.guideIsVisible,
      required this.heading,
      required this.liturgyList,
      required this.lyricsList,
      required this.createAt});

  final String createAt;
  final String theme;
  final String preacher;
  final bool guideIsVisible;
  final String title;
  final String heading;
  final List<LyricEntity> lyricsList;
  final List<LiturgyEntity> liturgyList;
}
