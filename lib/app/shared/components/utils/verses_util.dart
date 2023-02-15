import 'package:ipbc_palmas/app/lyric/infra/adapters/dtos/verse_dto_adapter.dart';
import 'package:uno/uno.dart';
import 'dart:convert';

import '../../../lyric/domain/entities/lyric_entity.dart';
import '../../../lyric/domain/entities/verse_entity.dart';
import '../../../lyric/infra/models/dtos/lyric_dto.dart';
import '../../../lyric/infra/models/dtos/verse_dto.dart';

class VersesUtil {
  final uno = Uno();

  Future<dynamic> getLyric(String title, String group) async {
    String titleParam = title.replaceAll(' ', '%20');
    String groupParam = group.replaceAll(' ', '%20');
    String apikey = 'a34faccfb8ad3edc6ddcc978e34802ef';
    try {
      final response = await uno.get(
          'https://api.vagalume.com.br/search.php?art=$groupParam&mus=$titleParam&apikey=$apikey');
      return response.data;
    } on UnoError catch (error) {
      print(error);
    }
  }

  Future<List<LyricDTO>> generateVersesList(List<LyricDTO> lyricsList) async {
    List<LyricDTO> results = [];
    for (int i = 0; lyricsList.length > i; i++) {
      Map<dynamic, dynamic> result = await getLyric(lyricsList[i].title, lyricsList[i].group);
      results.add(
        LyricDTO(
          verses: VerseDTOAdapter.fromVagalume(result),
          albumCover: '',
          id: '$i',
          title: '',
          createAt: DateTime.now(),
          group: '',
        ),
      );
    }
    return results;
  }
    //List versesConverted = lyric.textView.split(RegExp(r'(\n)'));
    //verses.add(
    //    VerseDTO(isChorus: v.isChorus, id: v.id, VersesList: versesConverted)
    //);

    /*for (LyricDTO v in lyricEntity) {

      List versesConverted = v.textView.split(RegExp(r'(\n)'));
      verses.add(
          VerseDTO(isChorus: v.isChorus, id: v.id, VersesList: versesConverted)
      );
    }*/

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
  // String gfg =
  "You say\nOne love, one life\nWhen it's one need\nIn the night\nOne love\nWe get to share\nIt leaves you, darling\nIf you don't care for it";

  //replace substring of the given string
  // String result = gfg.replaceAll("\n", "/n");
  //List resultList1 = gfg.split("\n");
  //print(resultList1);
  // List resultList2 = result.split("/n");
  //print(resultList2);
}
