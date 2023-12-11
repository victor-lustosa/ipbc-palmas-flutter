import 'package:core_module/core_module.dart';

import 'service/service_module.dart';
import 'lyric/lyric_module.dart';
import 'home/home_module.dart';

class MainModule extends Module {
  static const String authRoute = '/auth';
  static const String lyricsRoute = '/lyrics';
  static const String servicesRoute = '/services';
  static const String initRoute = '/init';

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(r) {
    r.module(authRoute, module: AuthModule());
    //r.child(splashRoute, child: (_) => const SplashView());
    r.module(initRoute, module: HomeModule());
    r.module(lyricsRoute, module: LyricModule());
    r.module(servicesRoute, module: ServiceModule());
  }
}
