import '../../../core/domain/use-cases/use_cases.dart';
import '../../../lyric/infra/models/firestore-dtos/services_collection_dto.dart';
import '../../../core/domain/repositories/repository.dart';
import '../adapters/services_collection_adapter.dart';

class CollectionsUseCases implements IUseCases<Stream<List<ServicesCollectionDTO>>> {
  final IRepository<Stream<List<Map>>> repository;
  CollectionsUseCases({required this.repository});

  @override
  Future<Stream<List<ServicesCollectionDTO>>> get(String url) async {
    var result = await repository.get(url);
    if (result != null) {
      return result.map(ServicesCollectionAdapter.fromMapList);
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
