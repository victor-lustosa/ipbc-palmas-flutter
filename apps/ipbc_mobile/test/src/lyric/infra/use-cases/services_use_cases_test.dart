
import 'package:flutter_test/flutter_test.dart';
import 'package:core_module/core_module.dart';
import '../../../../mocks/mocks.dart';
import 'package:mocktail/mocktail.dart';

void main() {
 /* test('getting services list in use case in firestore', () async {
    Repository<List<Map>> repository = RepositoryMock();
    Timestamp timestamp = Timestamp.now();
    Map entity =  {
      'id': '1',
      'title': 'Domingo à noite',
      'heading': 'domingo à noite',
      'createAt': timestamp,
      'image': 'assets/images/sunday_evening.png',
      'path': 'sunday-evening-services/20',
      'hour': '19h'
    };
    when(() => repository.get('services/20')).thenAnswer((_) => Future.value([entity]));
    final serviceUsecase = ServicesUseCases(repository: repository);
    final result = await serviceUsecase.get('services/20');
    expect(result, emits(isA<List<ServicesEntity>>()));
  });*/
}
