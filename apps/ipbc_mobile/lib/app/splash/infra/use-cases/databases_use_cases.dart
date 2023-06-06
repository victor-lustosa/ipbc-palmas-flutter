import 'package:core_module/core_module.dart';

import '../../../lyric/infra/models/hive-dtos/hive_database_configs_dto.dart';

class DatabasesUseCases implements IUseCases<Stream<HiveDatabaseConfigsDTO>> {
  final IRepository<Stream<HiveDatabaseConfigsDTO>> repository;
  DatabasesUseCases({required this.repository});

  @override
  Future<Stream<HiveDatabaseConfigsDTO>> get(String path) async {
    var result = await repository.get(path);
    return result!;
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
