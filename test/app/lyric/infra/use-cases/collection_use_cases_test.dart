import 'package:flutter_test/flutter_test.dart';
import 'package:ipbc_palmas/app/core/infra/repositories/repository.dart';
import 'package:ipbc_palmas/app/lyric/domain/entities/collection_entity.dart';
import 'package:ipbc_palmas/app/lyric/infra/use-cases/collection_use_cases.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../mocks/mocks.dart';

void main() {
  test('getting services collection in use case', () async {
    Repository<Stream<List<Map>>> repository = RepositoryMock();
    Timestamp timestamp = Timestamp.now();
    Map entity = {
      "id": "1",
      "createAt": "",
      "theme": "avivamento do Espirito",
      "preacher": "Pr Isaías",
      "title": "Sábado",
      "hour": "19h30",
      "type": "saturday-services",
      "heading": "sábado",
      "image": "assets/images/saturday_evening.png",
      "guideIsVisible": false,
      "lyricsList": [
        {
          "id": "",
          "title": "Quem e",
          "group": "diante do trono",
          "albumCover": "",
          "createAt": timestamp,
          "verses": []
        },
        {
          "id": "",
          "title": "Eu me rendo",
          "group": "Renascer Praise",
          "albumCover": "",
          "createAt": timestamp,
          "verses": []
        },
        {
          "id": "",
          "title": "Te louvarei",
          "group": "Toque no altar",
          "albumCover": "",
          "createAt": timestamp,
          "verses": []
        },
      ],
      "liturgyList": [],
    };
    when(() => repository.get('saturday-services/20')).thenAnswer(
      (_) => Future.value(
        Stream.value([entity]),
      ),
    );
    final collectionUsecase = CollectionUseCases(repository: repository);
    final result = await collectionUsecase.get('saturday-services/20');
    expect(result, emits(isA<List<CollectionEntity>>()));
  });
}
