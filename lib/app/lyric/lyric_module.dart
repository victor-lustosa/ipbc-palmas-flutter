import 'package:ipbc_palmas/app/shared/components/splash/infra/models/hive-dtos/database_configs_hive_dto.dart';
import 'package:ipbc_palmas/app/shared/components/splash/presentation/blocs/database_bloc.dart';

import '../core/external/firestore_datasource.dart';
import '../core/external/hive_datasource.dart';
import '../core/infra/repositories/repository.dart';
import '../shared/components/splash/infra/use-cases/databases_use_cases.dart';
import 'infra/use-cases/lyrics_use_cases.dart';
import 'infra/use-cases/services_use_cases.dart';
import 'presentation/blocs/lyric_bloc.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'presentation/blocs/service_bloc.dart';

final lyricModule = [
  Provider<Repository<Stream<List<Map<dynamic, dynamic>>>>>(
    create: (context) => Repository(
      datasource: FirestoreDatasource(
        firestore: FirebaseFirestore.instance,
      ),
    ),
  ),
  Provider<LyricBloc>(
    create: (context) => LyricBloc(
      lyricsUseCase: LyricsUseCases(
        repository:
            context.read<Repository<Stream<List<Map<dynamic, dynamic>>>>>(),
      ),
    ),
  ),
  Provider<ServiceBloc>(
    create: (context) => ServiceBloc(
      servicesUseCases: ServicesUseCases(
        repository:
            context.read<Repository<Stream<List<Map<dynamic, dynamic>>>>>(),
      ),
    ),
  ),
  Provider<DatabaseBloc>(
    create: (context) => DatabaseBloc(
      databasesUseCases: DatabasesUseCases(
        repository: Repository<DatabaseConfigsHiveDTO>(
          datasource: HiveDatasource<DatabaseConfigsHiveDTO>(
              boxLabel: 'database-configs'),
        ),
      ),
    ),
  ),
];
