import '../firestore-dtos/lyric_dto.dart';
import '../../../domain/entities/liturgy_entity.dart';

class ServiceDTO {
  ServiceDTO(
      {required this.id,
      required this.theme,
      required this.hour,
      required this.preacher,
      required this.type,
      required this.guideIsVisible,
      required this.liturgyList,
      required this.lyricsList,
      required this.createAt,
      required this.heading,
      required this.image,
      required this.title});
  final String id;
  final String image;
  final String theme;
  final String hour;
  final String preacher;
  final String type;
  final bool guideIsVisible;
  final DateTime createAt;
  final List<LyricDTO> lyricsList;
  final List<LiturgyEntity> liturgyList;
  final String title;
  final String heading;

  factory ServiceDTO.empty() => ServiceDTO(
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
      id: '');

  ServiceDTO copyWith(
      {DateTime? createAt,
      String? title,
      String? id,
      String? theme,
      String? preacher,
      String? type,
      String? hour,
      String? image,
      String? heading,
      bool? guideIsVisible,
      List<LyricDTO>? lyricsList,
      List<LiturgyEntity>? liturgyList}) {
    return ServiceDTO(
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
