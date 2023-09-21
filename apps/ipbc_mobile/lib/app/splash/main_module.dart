import 'package:core_module/core_module.dart';
import '../home/home_module.dart';
import '../lyric/lyric_module.dart';
import 'blocs/database_bloc.dart';

import '../shared/view-models/database_view_model.dart';
import 'views/splash_view.dart';

class MainModule extends Module {
  static const String splashRoute = '/splash';
  static const String authRoute = '/auth';
  static const String lyricsRoute = '/lyrics';
  static const String initRoute = '/init';

  @override
  void binds(i) {
    i.addSingleton<DatabaseViewModel>(DatabaseViewModel.new);
    i.addSingleton<DatabaseBloc>(
      () => DatabaseBloc(
        useCases: DatabasesUseCases(
          repository: Repository<HiveDatabaseConfigsDTO>(
            datasource: HiveDatasource<HiveDatabaseConfigsDTO>(
                boxLabel: 'database-configs'),
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
    r.module(authRoute, module: AuthModule());
    r.child(splashRoute, child: (_) => const SplashView());
    r.module(initRoute, module: HomeModule());
    r.module(lyricsRoute, module: LyricModule());
  }
}
