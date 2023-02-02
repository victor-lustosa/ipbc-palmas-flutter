import 'package:flutter_test/flutter_test.dart';
import 'package:ipbc_palmas/app/core/infra/repositories/repository.dart';
import 'package:ipbc_palmas/app/lyric/domain/entities/lyric_entity.dart';
import 'package:ipbc_palmas/app/lyric/domain/use-cases/lyrics_use_cases.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mocks.dart';

void main() {
  test('getting lyrics in use case', () {
    Repository<LyricEntity> repository = RepositoryMock();

    //final entity = LyricEntityMock();
    Map<dynamic, dynamic> entity = {
      'id': 'dfsdfsd',
      'title': 'agua viva',
      'group': 'oficina g3',
      'verses': [
        {
          'id': 0,
          'isChorus': false,
          'versesList': [
            {
              'Vejo em Seu rosto uma luz',
              'E o convido a ficar',
              'Sua voz me constrange',
              'Anseio escutar'
            }
          ],
        },
      ],
    };
    when(() => repository.get('lyrics'))
        .thenAnswer((_) => Stream.value([entity]));

    final usecase = LyricsUseCases(repository: repository);

    final result = usecase.get('');

    expect(result, emits(isA<List<LyricEntity>>()));
  });
}
