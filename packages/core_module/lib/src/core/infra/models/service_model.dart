
import 'package:core_module/core_module.dart';

class ServiceModel extends ServiceEntity {
  ServiceModel(
      {required super.id,
      required super.image,
      required super.theme,
      required super.hour,
      required super.preacher,
      required super.type,
      required super.guideIsVisible,
      required super.createAt,
      required super.lyricsList,
      required super.liturgiesList,
      required super.title,
      required super.heading
      });

  factory ServiceModel.empty() => ServiceModel(
      createAt: DateTime.now(),
      lyricsList: [],
      liturgiesList: [],
      title: '',
      theme: '',
      hour: '',
      image: '',
      preacher: '',
      type: '',
      heading: '',
      guideIsVisible: false,
      id: SupaServicesUtil.createId());

  ServiceModel copyWith({
    DateTime? createAt,
    String? title,
    int? id,
    String? theme,
    String? preacher,
    String? type,
    String? hour,
    String? image,
    String? heading,
    bool? guideIsVisible,
    List<LyricModel>? lyricsList,
    List<LiturgyEntity>? liturgiesList}) {
    return ServiceModel(
      title: title ?? this.title,
      image: image ?? this.image,
      hour: hour ?? this.hour,
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
