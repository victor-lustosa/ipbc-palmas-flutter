import 'package:flutter_test/flutter_test.dart';
import 'package:ipbc_palmas/app/core/infra/repositories/repository.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../mocks/mocks.dart';

void main() {
  test('getting lyrics in repository', () {
    final datasource = IGetDatasourceMock();
    when(() => datasource.get('lyrics/1')).thenAnswer(
      (_) => Stream.value(
        [
          {
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
          }
        ],
      ),
    );

    final repository = Repository(getDatasource: datasource);

    final result = repository.get('lyrics/1');
    expect(result, emits(isA<List<dynamic>>()));
  });
}
