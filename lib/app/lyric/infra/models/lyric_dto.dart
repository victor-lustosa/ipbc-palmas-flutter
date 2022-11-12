import 'package:ipbc_palmas/app/lyric/infra/models/verse_dto.dart';

class LyricDTO {
  final List<VerseDTO> versesList;

  LyricDTO({required this.versesList});

  @override
  String toString() {
    return 'LyricDTO{VersesList: $versesList}';
  }
}
