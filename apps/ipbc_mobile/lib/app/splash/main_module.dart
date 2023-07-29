import 'package:core_module/core_module.dart';
import 'blocs/database_bloc.dart';
import '../home/view-models/home_view_model.dart';
import '../splash/view-models/database_view_model.dart';

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
    create: (context) => HiveDatasource<HiveDatabaseConfigsDTO>(boxLabel: 'database-configs'),
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
