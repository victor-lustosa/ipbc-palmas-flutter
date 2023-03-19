
import 'package:ipbc_palmas/app/shared/components/splash/infra/models/hive-dtos/database_configs_hive_dto.dart';

import '../../../../../core/domain/repositories/repository.dart';
import '../../../../../core/domain/use-cases/use_cases.dart';

class DatabasesUseCases implements IUseCases<DatabaseConfigsHiveDTO> {
  final IRepository<DatabaseConfigsHiveDTO> repository;
  DatabasesUseCases({required this.repository});

  /*List<ServiceEntity> _convert(List<Map<dynamic, dynamic>> entity) {
    return ServiceAdapter.servicesListDecode(entity);
  }*/

  @override
  DatabaseConfigsHiveDTO? get(String path) {
    return repository.get(path);
  }
}
