import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/external/firestore_datasource.dart';
import 'presentation/blocs/database_bloc.dart';

import '../core/external/hive_datasource.dart';
import '../core/infra/repositories/repository.dart';
import '../lyric/infra/models/hive-dtos/hive_database_configs_dto.dart';

import 'package:provider/provider.dart';
import 'infra/use-cases/databases_use_cases.dart';

final mainModule = [
  Provider<FirestoreDatasource>(
    create: (_) => FirestoreDatasource(
      firestore: FirebaseFirestore.instance,
    ),
  ),
  Provider<Repository<HiveDatabaseConfigsDTO>>(
    create: (_) => Repository<HiveDatabaseConfigsDTO>(
      datasource: HiveDatasource<HiveDatabaseConfigsDTO>(boxLabel: 'database-configs'),
    ),
  ),
  Provider<DatabaseBloc>(
    create: (context) => DatabaseBloc(
      databasesUseCases: DatabasesUseCases(
        repository: context.read<Repository<HiveDatabaseConfigsDTO>>(),
      ),
    ),
  ),
];
