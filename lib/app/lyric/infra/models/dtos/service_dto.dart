import '../dtos/liturgy_dto.dart';
import '../dtos/lyric_dto.dart';

class ServiceDTO {
  ServiceDTO(
      {required this.liturgyList, required this.lyricsList, required this.createAt,  required this.heading,required this.title});

  final DateTime createAt;
  final List<LyricDTO> lyricsList;
  final List<LiturgyDTO> liturgyList;
  final String title;
  final String heading;

  factory ServiceDTO.empty() =>
      ServiceDTO(createAt: DateTime.now(), lyricsList: [], liturgyList: [],title:'',heading: '');

  ServiceDTO copyWith(
      {DateTime? createAt,
        String? title,
        String? heading,
        List<LyricDTO>? lyricsList,
        List<LiturgyDTO>? liturgyList}) {
    return ServiceDTO(
        title: title ?? this.title,
        heading: heading ?? this.heading,
        createAt: createAt ?? this.createAt,
        lyricsList: lyricsList ?? this.lyricsList,
        liturgyList: liturgyList ?? this.liturgyList);
  }

  @override
  String toString() {
    return 'ServiceDTO{createAt: $createAt, lyricsList: $lyricsList, liturgyList: $liturgyList,title: $title,heading: $heading}';
  }
}
