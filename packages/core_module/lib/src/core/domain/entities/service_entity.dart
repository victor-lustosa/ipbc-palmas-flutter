import 'package:core_module/core_module.dart';

class ServiceEntity {
  ServiceEntity({
    this.id,
    required this.type,
    this.liturgiesTableId,
    required this.serviceDate,
    this.serviceLiturgiesTableId,
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
  final DateTime createAt;
  final DateTime serviceDate;
  final String theme;
  final String? serviceLiturgiesTableId;
  final String? liturgiesTableId;
  final String preacher;
  final bool guideIsVisible;
  final String title;
  final String heading;
  final List<LyricEntity>? lyricsList;
  final List<LiturgyEntity>? liturgiesList;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ServiceEntity &&
        other.runtimeType == runtimeType &&
        other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
