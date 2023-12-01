import 'package:flutter_test/flutter_test.dart';
import 'package:core_module/core_module.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../mocks/mocks.dart';

void main() {
  /*test('getting services collection in use case in firestore', () async {
    Repository<List<Map>> repository = RepositoryMock();
    Timestamp timestamp = Timestamp.now();
    Map entity = {
      "id": "1",
      "createAt": DateTime.now().toString(),
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
      (_) => Future.value([entity]
      ),
    );
    final collectionUsecase = ServiceUseCases(repository: repository);
    final result = await collectionUsecase.get('saturday-services/20');
    expect(result, emits(isA<List<ServiceEntity>>()));
  });*/
}
