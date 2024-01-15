
import 'package:lyric_module/lyric_module.dart';

class ServiceModel extends ServiceEntity {
  ServiceModel(
      {required int id,
      required String image,
      required String theme,
      required String hour,
      required String preacher,
      required String type,
      required bool guideIsVisible,
      required DateTime createAt,
      required List<LyricModel> lyricsList,
      required List<LiturgyEntity> liturgyList,
      required String title,
      required String heading
      }): super(
    id: id,
    image: image,
    theme: theme,
    hour: hour,
    preacher: preacher,
    type: type,
    guideIsVisible: guideIsVisible,
    createAt: createAt,
    lyricsList: lyricsList,
    liturgyList: liturgyList,
    title: title,
    heading: heading,
  );

  factory ServiceModel.empty() => ServiceModel(
      createAt: DateTime.now(),
      lyricsList: [],
      liturgyList: [],
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
    List<LiturgyEntity>? liturgyList}) {
    return ServiceModel(
      title: title ?? this.title,
      image: image ?? this.image,
      hour: hour ?? this.hour,
      heading: heading ?? this.heading,
      createAt: createAt ?? this.createAt,
      lyricsList: lyricsList ?? this.lyricsList,
      liturgyList: liturgyList ?? this.liturgyList,
      guideIsVisible: guideIsVisible ?? this.guideIsVisible,
      id: id ?? this.id,
      theme: theme ?? this.theme,
      preacher: preacher ?? this.preacher,
      type: type ?? this.type,
    );
  }
}
