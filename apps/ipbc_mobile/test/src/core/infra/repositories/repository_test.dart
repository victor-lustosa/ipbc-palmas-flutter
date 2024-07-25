import 'package:flutter_test/flutter_test.dart';
import 'package:home_module/home_module.dart';
import '../../../../mocks/mocks.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  test('getting lyrics in repository', () async {
    final datasource = IDatasourceMock();
    when(() => datasource.get('lyrics/1')).thenAnswer(
      (_) => Future.value(Stream.value(
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
    ));

    final repository = Repository(datasource: datasource);

    final result = await repository.get('lyrics/1');
    expect(result, emits(isA<List<dynamic>>()));
  });
}
