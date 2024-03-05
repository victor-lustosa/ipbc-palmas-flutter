import 'package:core_module/core_module.dart';

import '../../app/splash/views/splash_views.dart';
import '../home/home_module.dart';
import 'blocs/database_bloc.dart';

class SplashModule extends Module {

  static const String initialRoute = '/';
  static const String splashRoute = '/splash';

  @override
  List<Module> get imports => [AuthModule()];

  @override
  void binds(i) {
    i.add(() => DatabaseBloc(useCases: i.get<AuthUseCase>()));
  }

  @override
  void routes(r) {
    r.child(splashRoute, child: (_) => const SplashView());
    r.module(initialRoute, module: HomeModule());
    r.module(AuthModule.authRoute, module: AuthModule());
    r.module(LyricModule.lyricsRoute, module: LyricModule());
    r.module(ServiceModule.servicesRoute, module: ServiceModule());
  }
}