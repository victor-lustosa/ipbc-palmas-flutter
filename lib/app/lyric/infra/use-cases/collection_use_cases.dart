import '../adapters/collection_adapter.dart';
import '../../domain/entities/collection_entity.dart';
import '../../../core/domain/use-cases/use_cases.dart';
import '../../../core/domain/repositories/repository.dart';

class CollectionUseCases implements IUseCases<Stream<List<CollectionEntity>>>{
  final IRepository<Stream<List<Map>>> repository;
  CollectionUseCases({required this.repository});

  @override
  Future<Stream<List<CollectionEntity>>> get(String url) async {
    var result = await repository.get(url);
    if (result != null) {
      return result.map(CollectionAdapter.fromMapList);
    }
    return Stream.value([]);
  }

  @override
  Future<void> add(path, data) async {
    repository.add(path, data);
  }

  @override
  Future<void> update(path, data) async {
    repository.update(path, data);
  }

}
