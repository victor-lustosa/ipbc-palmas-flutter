import '../../../domain/entities/liturgy_entity.dart';
import '../firestore-dtos/lyric_dto.dart';

class ServiceDTO {
  ServiceDTO(
        {
        required this.guideIsVisible,
        required this.liturgyList,
        required this.lyricsList,
        required this.createAt,
        required this.heading,
        required this.title
        }
      );
  final bool guideIsVisible;
  final DateTime createAt;
  final List<LyricDTO> lyricsList;
  final List<LiturgyEntity> liturgyList;
  final String title;
  final String heading;

  @override
  String toString() {
    return 'ServiceDTO{guideIsVisible: $guideIsVisible, createAt: $createAt, lyricsList: $lyricsList, liturgyList: $liturgyList, title: $title, heading: $heading}';
  }

  factory ServiceDTO.empty() => ServiceDTO(
      createAt: DateTime.now(),
      lyricsList: [],
      liturgyList: [],
      title: '',
      heading: '',
      guideIsVisible: false);

  ServiceDTO copyWith(
      {DateTime? createAt,
      String? title,
      String? heading,
      bool? guideIsVisible,
      List<LyricDTO>? lyricsList,
      List<LiturgyEntity>? liturgyList}) {
    return ServiceDTO(
        title: title ?? this.title,
        heading: heading ?? this.heading,
        createAt: createAt ?? this.createAt,
        lyricsList: lyricsList ?? this.lyricsList,
        liturgyList: liturgyList ?? this.liturgyList,
        guideIsVisible: guideIsVisible ?? this.guideIsVisible);
  }

}
