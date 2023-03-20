/*
import '../../../lyric/infra/adapters/dtos/verse_dto_adapter.dart';
import 'package:uno/uno.dart';
import '../../../lyric/infra/models/dtos/lyric_dto.dart';


class AlbumCoverUtil {
  final uno = Uno();

  Future<dynamic> getAlbumCover(String title, String group) async {
    String titleParam = title.replaceAll(' ', '%20');
    String groupParam = group.replaceAll(' ', '%20');
    String apikey = 'a34faccfb8ad3edc6ddcc978e34802ef';
    try {
      final response = await uno.get(
          'https://musicbrainz.org/ws/2/release-group?query=artistname:${groupParam}AND%20release:$titleParam');
      return response.data;
    } on UnoError catch (error) {
      print(error);
    }
  }

  Future<List<LyricDTO>> gettingAlbumCoversList(List<LyricDTO> lyricsList) async {
    List<LyricDTO> results = [];
    for (int i = 0; lyricsList.length > i; i++) {
      Map result = await getAlbumCover(lyricsList[i].title, lyricsList[i].group);
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
}

*/