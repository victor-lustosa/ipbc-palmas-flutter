import '../dtos/liturgy_dto.dart';
import '../dtos/lyric_dto.dart';

class ServiceDTO {
  ServiceDTO(
      {required this.liturgyList, required this.lyricsList, required this.createAt});

  final DateTime createAt;
  final List<LyricDTO> lyricsList;
  final List<LiturgyDTO> liturgyList;

  factory ServiceDTO.empty() =>
      ServiceDTO(createAt: DateTime.now(), lyricsList: [], liturgyList: []);

  ServiceDTO copyWith(
      {DateTime? createAt,
        List<LyricDTO>? lyricsList,
        List<LiturgyDTO>? liturgyList}) {
    return ServiceDTO(
        createAt: createAt ?? this.createAt,
        lyricsList: lyricsList ?? this.lyricsList,
        liturgyList: liturgyList ?? this.liturgyList);
  }

  @override
  String toString() {
    return 'ServiceDTO{createAt: $createAt, lyricsList: $lyricsList, liturgyList: $liturgyList}';
  }
}
