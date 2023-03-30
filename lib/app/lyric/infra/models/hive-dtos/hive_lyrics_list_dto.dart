import 'lyric_hive_dto.dart';
import 'package:hive/hive.dart';
part 'hive_lyrics_list_dto.g.dart';

@HiveType(typeId: 6)
class HiveLyricsListDTO {
  @HiveField(0)
  List<LyricHiveDTO> lyricsList;

  HiveLyricsListDTO({required this.lyricsList});
}
