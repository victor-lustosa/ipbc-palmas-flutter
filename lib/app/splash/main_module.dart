import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'presentation/blocs/database_bloc.dart';
import 'infra/use-cases/databases_use_cases.dart';
import '../core/external/hive_datasource.dart';
import '../home/view-models/home_view_model.dart';
import '../core/external/firestore_datasource.dart';
import '../core/infra/repositories/repository.dart';
import '../shared/components/utils/analytics_util.dart';
import '../splash/presentation/view-models/database_view_model.dart';
import '../lyric/infra/models/hive-dtos/hive_database_configs_dto.dart';

final mainModule = [
  Provider<DatabaseViewModel>(
    create: (_) => DatabaseViewModel(),
  ),
  Provider<AnalyticsUtil>(
    create: (_) => AnalyticsUtil(),
  ),
  Provider<FirestoreDatasource>(
    create: (_) => FirestoreDatasource(
      firestore: FirebaseFirestore.instance,
    ),
  ),
  ChangeNotifierProvider<HomeViewModel>(
    create: (_) => HomeViewModel(),
  ),
  Provider<HiveDatasource<HiveDatabaseConfigsDTO>>(
    create: (context) =>
        HiveDatasource<HiveDatabaseConfigsDTO>(boxLabel: 'database-configs'),
  ),
  Provider<Repository<HiveDatabaseConfigsDTO>>(
    create: (context) => Repository<HiveDatabaseConfigsDTO>(
        datasource: context.read<HiveDatasource<HiveDatabaseConfigsDTO>>()),
  ),
  Provider<DatabaseBloc>(
    create: (context) => DatabaseBloc(
        databasesUseCases: DatabasesUseCases(
          repository: Repository<Stream<HiveDatabaseConfigsDTO>>(
            datasource: context.read<HiveDatasource<HiveDatabaseConfigsDTO>>(),
          ),
        ),
        analyticsUtil: context.read<AnalyticsUtil>(),
    ),
  ),
];
