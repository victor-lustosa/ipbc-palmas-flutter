
import '../core/external/hive_datasource.dart';
import '../core/infra/repositories/repository.dart';
import '../shared/components/splash/infra/models/hive-dtos/database_configs_hive_dto.dart';
import '../shared/components/splash/infra/use-cases/databases_use_cases.dart';
import '../shared/components/splash/presentation/blocs/database_bloc.dart';

import 'package:provider/provider.dart';


final splashModule = [
  Provider<Repository<Stream<List<DatabaseConfigsHiveDTO>>>>(
    create: (context) => Repository<Stream<List<DatabaseConfigsHiveDTO>>>(
      datasource: HiveDatasource(boxLabel: 'lyric'),
    ),
  ),
  Provider<DatabaseBloc>(
    create: (context) => DatabaseBloc(
      databasesUseCases: DatabasesUseCases(
        repository: context.read<Repository<Stream<List<DatabaseConfigsHiveDTO>>>>(),
        ),
      ),
    ),
];
