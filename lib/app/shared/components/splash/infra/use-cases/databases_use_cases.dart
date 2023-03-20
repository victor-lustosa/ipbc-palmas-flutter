
import '../../../../../shared/components/splash/infra/models/hive-dtos/database_configs_hive_dto.dart';

import '../../../../../core/domain/repositories/repository.dart';
import '../../../../../core/domain/use-cases/use_cases.dart';

class DatabasesUseCases implements IUseCases<Stream<List<DatabaseConfigsHiveDTO>>> {
  final IRepository<Stream<List<DatabaseConfigsHiveDTO>>> repository;
  DatabasesUseCases({required this.repository});

  @override
  Stream<List<DatabaseConfigsHiveDTO>> get(String path) {
      return repository.get(path);
  }
}
