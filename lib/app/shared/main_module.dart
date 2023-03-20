
import 'package:ipbc_palmas/app/shared/components/splash/infra/models/hive-dtos/database_configs_hive_dto.dart';

import '../core/external/hive_datasource.dart';
import '../core/infra/repositories/repository.dart';
import '../shared/components/splash/infra/use-cases/databases_use_cases.dart';
import '../shared/components/splash/presentation/blocs/database_bloc.dart';

import 'package:provider/provider.dart';

final mainModule = [
  Provider<Repository<Stream<List<Map<dynamic, dynamic>>>>>(
    create: (context) => Repository<Stream<List<Map<dynamic, dynamic>>>>(
      datasource: HiveDatasource<DatabaseConfigsHiveDTO>(boxLabel: 'database-configs'),
    ),
  ),
  Provider<DatabaseBloc>(
    create: (context) => DatabaseBloc(
      databasesUseCases: DatabasesUseCases(
        repository: context.read<Repository<Stream<List<Map<dynamic, dynamic>>>>>(),
        ),
      ),
    ),
];
