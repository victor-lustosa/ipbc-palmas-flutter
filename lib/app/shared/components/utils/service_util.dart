import 'dart:math';
import 'package:uno/uno.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../../../lyric/infra/adapters/firestore-dtos/verse_dto_adapter.dart';
import '../../../lyric/infra/models/firestore-dtos/lyric_dto.dart';
import '../../../lyric/infra/models/firestore-dtos/service_dto.dart';
import '../../configs/app_configs.dart';

class ServiceUtil {
  static const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();
//utilizar pra criar o codigo no firestore
 static String createId(int length) => String.fromCharCodes(
     Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)))
 );

  static Future<dynamic> getLyric(String title, String group) async {
    String titleParam = title.replaceAll(' ', '%20');
    String groupParam = group.replaceAll(' ', '%20');
    String apikey = 'a34faccfb8ad3edc6ddcc978e34802ef';
    try {
      final response = await Uno().get('https://api.vagalume.com.br/search.php?art=$groupParam&mus=$titleParam&apikey=$apikey');
      return response.data;
    } on UnoError catch (error) {
      await FirebaseCrashlytics.instance.recordError(error.message, error.stackTrace, reason: 'a non-fatal error');
    }
  }

 static generateService(ServiceDTO service, int index) async {
   List<LyricDTO> lyricsConverted = await generateVersesList(service.lyricsList);
   List<LyricDTO> lyricsAux = [];
   //aqui vai o codigo para alterar a capa do album
     for (int line = 0; service.lyricsList.length > line; line++) {
       lyricsAux.add(
         service.lyricsList[line].copyWith(
           id: lyricsConverted[line].id,
           verses: lyricsConverted[line].verses,
           albumCover: lyricsConverted[line].albumCover,
         ),
       );
     }
     return service.copyWith(id: '$index',lyricsList: lyricsAux);
   }

  static Future<List<LyricDTO>> generateVersesList(List<LyricDTO> lyricsList) async {
    List<LyricDTO> results = [];
    for (int i = 0; lyricsList.length > i; i++) {
      Map result = await getLyric(lyricsList[i].title, lyricsList[i].group);
      results.add(
        LyricDTO(
          verses: VerseDTOAdapter.fromVagalume(result),
          albumCover: AppImages.defaultCoversList[Random().nextInt(4)],
          id: '$i',
          title: '',
          createAt: DateTime.now(),
          group: '',
        ),
      );
    }
    return results;
  }
}

