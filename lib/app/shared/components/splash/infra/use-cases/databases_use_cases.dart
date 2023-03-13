
import '../../../../../core/domain/repositories/repository.dart';
import '../../domain/use-cases/databases_use_cases.dart';
import '../adapters/service_adapter.dart';
import '../models/hive-dtos/service_hive_dto.dart';

class DatabasesUseCases implements IDatabasesUseCases<ServiceHiveDTO> {
  final IRepository<Stream<List<Map<dynamic, dynamic>>>> repository;
  DatabasesUseCases({required this.repository});

  List<ServiceHiveDTO> _convert(List<Map<dynamic, dynamic>> entity) {
    return ServiceAdapter.servicesListDecode(entity);
  }

  @override
  Stream<List<ServiceHiveDTO>> get() {
    var services = repository.get('hive');
    return services.map(_convert);
  }
}
