
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_module/core_module.dart';
import 'package:ipbc_palmas/app/lyric/domain/entities/services_entity.dart';
import 'package:ipbc_palmas/app/lyric/infra/use-cases/services_use_cases.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../mocks/mocks.dart';

void main() {
  test('getting services list in use case', () async {
    Repository<Stream<List<Map>>> repository = RepositoryMock();
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
    when(() => repository.get('services/20')).thenAnswer((_) => Future.value(Stream.value([entity])));
    final serviceUsecase = ServicesUseCases(repository: repository);
    final result = await serviceUsecase.get('services/20');
    expect(result, emits(isA<List<ServicesEntity>>()));
  });
}
