import 'hive_lyric_dto.dart';
import 'package:hive/hive.dart';
part 'hive_lyrics_list_dto.g.dart';

@HiveType(typeId: 6)
class HiveLyricsListDTO {
  @HiveField(0)
  List<HiveLyricDTO> lyricsList;

  HiveLyricsListDTO({required this.lyricsList});
}
