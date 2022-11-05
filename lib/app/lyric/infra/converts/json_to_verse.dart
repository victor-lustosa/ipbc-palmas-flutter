import '../../domain/entities/verse_entity.dart';

class JsonToVerse {
  static VerseEntity fromMap(dynamic json) {
    return VerseEntity(
      id: json['id'],
      isChorus: json['isChorus'],
      versesList: json['versesList'],
    );
  }
}
