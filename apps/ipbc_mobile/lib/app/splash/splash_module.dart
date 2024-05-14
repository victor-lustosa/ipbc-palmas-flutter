import 'package:auth_module/auth_module.dart';
import 'package:events_module/events_module.dart';
import 'package:lyric_module/lyric_module.dart';
import 'package:service_module/service_module.dart';

import '../../app/splash/views/splash_view.dart';

import '../init/init_module.dart';
import 'blocs/database_bloc.dart';

class SplashModule extends Module {
  static const String splashRoute = '/splash';

  @override
  List<Module> get imports => [
        CoreModule(),
        AuthModule(),
      ];

  @override
  void binds(i) {
    i.addSingleton(
      () => DatabaseBloc(
        useCases: i.get<AuthUseCase>(),
      ),
    );
  }

  @override
  void routes(r) {
    r.child(splashRoute, child: (_) => const SplashView());
    r.module(InitModule.initialRoute, module: InitModule());
    r.module(AuthModule.authRoute, module: AuthModule());
    r.module(LyricModule.lyricsRoute, module: LyricModule());
    r.module(ServiceModule.servicesRoute, module: ServiceModule());
    r.module(EventModule.eventRoute, module: EventModule());
  }
}
