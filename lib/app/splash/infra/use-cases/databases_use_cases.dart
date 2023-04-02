import '../../../core/domain/use-cases/use_cases.dart';
import '../../../lyric/infra/models/hive-dtos/hive_database_configs_dto.dart';
import '../../../core/domain/repositories/repository.dart';

class DatabasesUseCases implements IUseCases<Stream<HiveDatabaseConfigsDTO>> {
  final IRepository<HiveDatabaseConfigsDTO> repository;
  DatabasesUseCases({required this.repository});

  @override
  Future<Stream<HiveDatabaseConfigsDTO>> get(String path) async {
   HiveDatabaseConfigsDTO? result = await repository.get(path);
   if(result != null){
    return Stream.value(result);
    }
   return Stream.value(HiveDatabaseConfigsDTO(updateAt: DateTime.parse('2000-01-01')));
  }

  @override
  Future<void> add(path, data) async {
    repository.add(path, data);
  }
}
