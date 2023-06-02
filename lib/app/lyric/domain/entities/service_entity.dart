import 'package:ipbc_palmas/app/lyric/infra/models/lyric_model.dart';
import 'liturgy_entity.dart';

class ServiceEntity {
  
  ServiceEntity({
      required this.id,
      required this.type,
      required this.hour,
      required this.theme,
      required this.image,
      required this.preacher,
      required this.title,
      required this.guideIsVisible,
      required this.heading,
      required this.liturgyList,
      required this.lyricsList,
      required this.createAt});

  final String id;
  final String type;
  final String image;
  final String hour;
  final DateTime createAt;
  final String theme;
  final String preacher;
  final bool guideIsVisible;
  final String title;
  final String heading;
  final List<LyricModel> lyricsList;
  final List<LiturgyEntity> liturgyList;

}
