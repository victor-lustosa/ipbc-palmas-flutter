
import '../../../../core_module.dart';

class DatabasesUseCases implements IUseCases<HiveDatabaseConfigsDTO> {
  final IRepository<HiveDatabaseConfigsDTO> repository;
  DatabasesUseCases({required this.repository});

  @override
  Future<HiveDatabaseConfigsDTO?> get(String path) async {
    var result = await repository.get(path);
    return result;
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
