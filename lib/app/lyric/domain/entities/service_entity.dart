import 'lyric_entity.dart';
import '../../infra/models/dtos/liturgy_dto.dart';

class ServiceEntity {
  ServiceEntity({required this.liturgyList, required this.lyricsList, required this.createAt});
  final String createAt;
  final List<LyricEntity> lyricsList;
  final List<LiturgyDTO> liturgyList;
}
