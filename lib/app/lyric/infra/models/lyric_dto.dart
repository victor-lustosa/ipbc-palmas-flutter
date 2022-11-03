import 'package:ipbc_palmas/app/lyric/infra/models/verse_dto.dart';

class LyricDTO{

  final List<VerseDTO> VersesList;

  LyricDTO( {required this.VersesList});

  @override
  String toString() {
    return 'LyricDTO{VersesList: $VersesList}';
  }
}