import 'package:core_module/core_module.dart';

class ServiceModel extends ServiceEntity {
  ServiceModel({
    super.id,
    super.image,
    required super.theme,
    required super.preacher,
    required super.liturgiesTableId,
    super.serviceLiturgiesTableId,
    required super.serviceDate,
    required super.type,
    required super.guideIsVisible,
    required super.createAt,
    required super.lyricsList,
    required super.liturgiesList,
    required super.title,
    required super.heading,
  });

  factory ServiceModel.empty() => ServiceModel(
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

  ServiceModel copyWith({
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
    List<LyricModel>? lyricsList,
    List<LiturgyEntity>? liturgiesList,
  }) {
    return ServiceModel(
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
