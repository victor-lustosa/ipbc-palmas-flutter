import 'package:ipbc_palmas/app/lyric/infra/models/lyric_dto.dart';

import '../../../lyric/domain/entities/lyric_entity.dart';
import '../../../lyric/domain/entities/verse_entity.dart';
import '../../../lyric/infra/models/verse_dto.dart';

class Util {
 /* static List<VerseDTO> generateVersesList(LyricEntity lyricEntity) {

    List<VerseDTO> verses = [];

    for (VerseEntity v in lyricEntity.verses) {

      List versesConverted = v.textView.split(RegExp(r'(\n)'));
      verses.add(
          VerseDTO(isChorus: v.isChorus, id: v.id, VersesList: versesConverted)
      );
    }
    return verses;
  }*/
}

void main() {
  String gfg =
      "You say\nOne love, one life\nWhen it's one need\nIn the night\nOne love\nWe get to share\nIt leaves you, darling\nIf you don't care for it";

  //replace substring of the given string
  String result = gfg.replaceAll("\n", "/n");
  List resultList1 = gfg.split("\n");
  print(resultList1);
  List resultList2 = result.split("/n");
  print(resultList2);
}
