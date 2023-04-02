import '../../../domain/entities/liturgy_entity.dart';
import '../firestore-dtos/lyric_dto.dart';

class ServiceDTO {
  ServiceDTO(
        {
        required this.id,
          required this.theme,
          required this.preacher,
          required this.type,
        required this.guideIsVisible,
        required this.liturgyList,
        required this.lyricsList,
        required this.createAt,
        required this.heading,
        required this.title
        }
      );
  final String id;
  final String theme;
  final String preacher;
  final String type;
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
      theme: '',
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
        guideIsVisible: guideIsVisible ?? this.guideIsVisible,
        id: id ?? this.id,
        theme: theme ?? this.theme,
        preacher: preacher ?? this.preacher,
        type: type ?? this.type,
    );
  }

}
