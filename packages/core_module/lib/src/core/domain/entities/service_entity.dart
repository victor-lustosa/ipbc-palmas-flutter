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

  factory ServiceEntity.empty() => ServiceEntity(
    createAt: DateTime.now(),
    lyricsList: [],
    liturgiesList: [],
    title: '',
    serviceLiturgiesTableId: '',
    liturgiesTableId: '',
    serviceDate: DateTime.now(),
    theme: '',
    image: '',
    preacher: '',
    type: '',
    heading: '',
    guideIsVisible: false,
  );

  ServiceEntity copyWith({
    DateTime? createAt,
    DateTime? serviceDate,
    String? title,
    String? id,
    String? theme,
    String? serviceLiturgiesTableId,
    String? liturgiesTableId,
    String? preacher,
    String? type,
    String? image,
    String? heading,
    bool? guideIsVisible,
    List<LyricEntity>? lyricsList,
    List<LiturgyEntity>? liturgiesList,
  }) {
    return ServiceEntity(
      title: title ?? this.title,
      serviceLiturgiesTableId: serviceLiturgiesTableId ?? this.serviceLiturgiesTableId,
      liturgiesTableId: liturgiesTableId ?? this.liturgiesTableId,
      image: image ?? this.image,
      serviceDate: serviceDate ?? this.serviceDate,
      heading: heading ?? this.heading,
      createAt: createAt ?? this.createAt,
      lyricsList: lyricsList ?? this.lyricsList,
      liturgiesList: liturgiesList ?? this.liturgiesList,
      guideIsVisible: guideIsVisible ?? this.guideIsVisible,
      id: id ?? this.id,
      theme: theme ?? this.theme,
      preacher: preacher ?? this.preacher,
      type: type ?? this.type,
    );
  }
}
