

import 'presentation/blocs/database_bloc.dart';

import '../core/external/hive_datasource.dart';
import '../core/infra/repositories/repository.dart';
import '../lyric/infra/models/hive-dtos/database_configs_hive_dto.dart';

import 'package:provider/provider.dart';

import 'infra/use-cases/databases_use_cases.dart';

final mainModule = [
  Provider<Repository<Stream<List<Map>>>>(
    create: (context) => Repository<Stream<List<Map>>>(
      datasource: HiveDatasource<DatabaseConfigsHiveDTO>(boxLabel: 'database-configs'),
    ),
  ),
  Provider<DatabaseBloc>(
    create: (context) => DatabaseBloc(
      databasesUseCases: DatabasesUseCases(
        repository: context.read<Repository<Stream<List<Map>>>>(),
        ),
      ),
    ),
];
