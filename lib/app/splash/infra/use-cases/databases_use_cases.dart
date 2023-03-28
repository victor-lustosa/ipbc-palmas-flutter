import '../../domain/use-cases/database_use_case.dart';
import '../../../lyric/infra/models/hive-dtos/database_configs_hive_dto.dart';
import '../../../core/domain/repositories/repository.dart';
import '../../../lyric/infra/adapters/hive-dtos/database_configs_hive_adapter.dart';

class DatabasesUseCases
    implements IDatabaseUseCases<Stream<DatabaseConfigsHiveDTO>> {
  final IRepository<Stream<List<Map>>> repository;
  DatabasesUseCases({required this.repository});

  /*DatabaseConfigsHiveDTO _convert(List<Map> entity) {
    return DatabaseConfigsHiveAdapter.fromMap(entity);
  }*/

  @override
  Stream<DatabaseConfigsHiveDTO> get(String path) {
    var result = repository.get(path);
    dynamic entity;
    result.listen((event) {}).onData(
      (data) {
        if (data.isNotEmpty) {
          entity = DatabaseConfigsHiveAdapter.fromMap(data);
        }
      },
    );
    return entity != null
        ? Stream.value(entity)
        : Stream.value(
            DatabaseConfigsHiveDTO(
              updateAt: DateTime.parse('2000-01-01'),
            ),
          );
  }

  @override
  Future<void> add(path, data) async {
    repository.add(path, data);
  }
}
