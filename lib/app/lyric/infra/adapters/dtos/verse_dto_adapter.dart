import '../../../domain/entities/verse_entity.dart';

class VerseDTOAdapter {

  static List verseDecode(dynamic json){
    List results = [];
    for(int i = 0; i < json[0].length ; i++){
      results.add(json[0]['verse$i']);
    }
    return results;
  }
  static VerseEntity fromMap(dynamic json) {
    return VerseEntity(
      id: json['id'],
      isChorus: json['isChorus'],
      versesList: verseDecode(json['versesList']),
    );
  }

}