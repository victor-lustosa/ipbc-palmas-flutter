import 'package:core_module/core_module.dart';

class ServiceEntity {
  ServiceEntity({
    this.id,
    required this.type,
    required this.hour,
    required this.theme,
    this.image,
    required this.preacher,
    required this.title,
    required this.guideIsVisible,
    required this.heading,
    this.liturgiesList,
    this.lyricsList,
    required this.createAt,
  });

  final String? id;
  final String type;
  final String? image;
  final String hour;
  final DateTime createAt;
  final String theme;
  final String preacher;
  final bool guideIsVisible;
  final String title;
  final String heading;
  final List<LyricEntity>? lyricsList;
  final List<LiturgyEntity>? liturgiesList;

}

class ServiceLiturgiesSupabase {
  final String? id;
  final int liturgyId;
  final int serviceId;

  ServiceLiturgiesSupabase({required this.id, required this.liturgyId, required this.serviceId});

}