import 'package:flutter_test/flutter_test.dart';
import 'package:ipbc_palmas/app/lyric/domain/entities/verse_entity.dart';
import 'package:ipbc_palmas/app/lyric/infra/converts/json_to_verse.dart';

void main() {
  test('converting json in a verse entity', () {
    final verse = JsonToVerse.fromMap({
      'id': 0,
      'isChorus': true,
      'versesList': [
        {
          'Vejo em Seu rosto uma luz',
          'E o convido a ficar',
          'Sua voz me constrange',
          'Anseio escutar'
        }
      ],
    });

    expect(verse, isA<VerseEntity>());
    expect(verse.isChorus, true);
  });
}
