import '../adapters/services_adapter.dart';
import '../../../core/domain/use-cases/use_cases.dart';
import '../../../core/domain/repositories/repository.dart';
import '../../../lyric/infra/models/firestore-dtos/services_dto.dart';

class ServicesUseCases implements IUseCases<Stream<List<ServicesDTO>>> {
  final IRepository<Stream<List<Map>>> repository;
  ServicesUseCases({required this.repository});

  @override
  Future<Stream<List<ServicesDTO>>> get(String url) async {
    var result = await repository.get(url);
    if (result != null) {
      return result.map(ServicesAdapter.fromMapList);
    }
    return Stream.value([]);
  }

  @override
  Future<void> add(path, data) async {
    repository.add(path, data);
  }

  @override
  Future<void> update(String path, data) async {
    repository.update(path, data);
  }

}
