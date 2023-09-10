import 'package:core_module/core_module.dart';
import '../home/home_module.dart';
import 'blocs/database_bloc.dart';

import '../splash/view-models/database_view_model.dart';
import 'views/splash_view.dart';

class MainModule extends Module {

  @override
  void binds(i) {
    i.addSingleton<DatabaseViewModel>(DatabaseViewModel.new);
    i.addSingleton<DatabaseBloc>(() => DatabaseBloc(
          databasesUseCases: DatabasesUseCases(
            repository: Repository<Stream<HiveDatabaseConfigsDTO>>(
              datasource: HiveDatasource<HiveDatabaseConfigsDTO>(boxLabel: 'database-configs'),
            ),
          ),
          analyticsUtil: i.get<AnalyticsUtil>(),
      ),
      config: CoreModule.blocConfig(),
    );
  }

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(r) {
    r.child('/', child: (_) => const SplashView());
    r.module('/home', module: HomeModule());
  }

}
