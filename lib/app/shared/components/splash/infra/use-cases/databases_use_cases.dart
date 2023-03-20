
import 'package:ipbc_palmas/app/shared/components/splash/infra/adapters/database_configs_hive_adapter.dart';

import '../../../../../shared/components/splash/infra/models/hive-dtos/database_configs_hive_dto.dart';

import '../../../../../core/domain/repositories/repository.dart';
import '../../../../../core/domain/use-cases/use_cases.dart';

class DatabasesUseCases implements IUseCases<Stream<DatabaseConfigsHiveDTO>> {
  final IRepository<Stream<List<Map<dynamic, dynamic>>>> repository;
  DatabasesUseCases({required this.repository});

  DatabaseConfigsHiveDTO _convert(List<Map<dynamic, dynamic>> entity) {
    return DatabaseConfigsHiveAdapter.fromMap(entity);
  }
  @override
  Stream<DatabaseConfigsHiveDTO> get(String path) {
      return repository.get(path).map(_convert);
  }
}
