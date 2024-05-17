
import 'package:flutter_test/flutter_test.dart';
import 'package:home_module/home_module.dart';
void main() {
  test('converting json in a verse entity', () {
    final verse = VerseAdapter.fromMap({
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
