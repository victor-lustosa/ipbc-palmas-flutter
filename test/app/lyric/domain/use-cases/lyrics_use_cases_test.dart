import 'package:flutter_test/flutter_test.dart';
import 'package:ipbc_palmas/app/core/infra/repositories/repository.dart';
import 'package:ipbc_palmas/app/lyric/domain/entities/lyric_entity.dart';
import 'package:ipbc_palmas/app/lyric/infra/use-cases/lyrics_use_cases.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../mocks/mocks.dart';

void main() {
  test('getting lyrics in use case', () {
    Repository<LyricEntity> repository = RepositoryMock();
    Timestamp timestamp = Timestamp.now();
    //final entity = LyricEntityMock();
    Map<dynamic, dynamic> entity = {
      'id': 'dfsdfsd',
      'title': 'agua viva',
      'group': 'oficina g3',
      'albumCover':
          'http://coverartarchive.org/release/ce82afc5-f866-400e-adcd-4a23c01dd877/4433492734-500.jpg',
      'createAt': timestamp,
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
    when(() => repository.get('lyrics/1'))
        .thenAnswer((_) => Stream.value([entity]));

    final lyricUsecase = LyricsUseCases(repository: repository);

    final result = lyricUsecase.get('lyrics/1');

    expect(result, emits(isA<List<LyricEntity>>()));
  });
}
