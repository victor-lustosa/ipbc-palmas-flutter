import '../../../core/domain/use-cases/use_cases.dart';
import '../../../lyric/infra/models/hive-dtos/database_configs_hive_dto.dart';
import '../../../core/domain/repositories/repository.dart';

class DatabasesUseCases implements IUseCases<Stream<DatabaseConfigsHiveDTO>> {
  final IRepository<DatabaseConfigsHiveDTO> repository;
  DatabasesUseCases({required this.repository});

  @override
  Future<Stream<DatabaseConfigsHiveDTO>> get(String path) async {
   DatabaseConfigsHiveDTO? result = await repository.get(path);
   if(result != null){
    return Stream.value(result);
    }
   return Stream.value(DatabaseConfigsHiveDTO(updateAt: DateTime.parse('2000-01-01')));
  }

  @override
  Future<void> add(path, data) async {
    repository.add(path, data);
  }
}
