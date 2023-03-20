
import '../../../lyric/infra/models/hive-dtos/database_configs_hive_dto.dart';
import '../../../core/domain/repositories/repository.dart';
import '../../../core/domain/use-cases/use_cases.dart';
import '../../../lyric/infra/adapters/hive-dtos/database_configs_hive_adapter.dart';

class DatabasesUseCases implements IUseCases<Stream<DatabaseConfigsHiveDTO>> {
  final IRepository<Stream<List<Map>>> repository;
  DatabasesUseCases({required this.repository});

  DatabaseConfigsHiveDTO _convert(List<Map> entity) {
    return DatabaseConfigsHiveAdapter.fromMap(entity);
  }
  @override
  Stream<DatabaseConfigsHiveDTO> get(String path) {
      return repository.get(path).map(_convert);
  }
}
