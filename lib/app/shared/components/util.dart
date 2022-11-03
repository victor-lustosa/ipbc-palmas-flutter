import 'package:ipbc_palmas/app/lyric/infra/models/lyric_dto.dart';

import '../../lyric/domain/entities/lyric_entity.dart';
import '../../lyric/domain/entities/verse_entity.dart';
import '../../lyric/infra/models/verse_dto.dart';

class Util {
  
  
  static List<VerseDTO>  generateVersesList(LyricEntity lyricEntity) {
    List<VerseDTO> verses=[];

    for(VerseEntity v in lyricEntity.verses){
      verses.add(VerseDTO(isChorus: v.isChorus, id: v.id, VersesList: v.textView.split("/n")));
        }
    return verses;

    
  }
}

