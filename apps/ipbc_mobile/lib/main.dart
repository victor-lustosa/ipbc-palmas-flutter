import 'package:core_module/core_module.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'app/services/service_module.dart';
import 'app/lyrics/lyric_module.dart';
import 'app/home/home_module.dart';

void main() async {
  Modular.setInitialRoute(
      MainModule.authRoute + AuthModule.verificationCodeRoute);
  WidgetsFlutterBinding.ensureInitialized();
  SupabaseDatasource.init();
  Bloc.observer = GenericBlocObserver();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (_) => runApp(
      ModularApp(
        module: MainModule(),
        child: MaterialApp.router(
          builder: (context, Widget? child) {
            return ScrollConfiguration(
              behavior: NoGlowBehavior(),
              child: child!,
            );
          },
          title: 'IPBC Palmas',
          theme: lightTheme,
          routerConfig: Modular.routerConfig,
          debugShowCheckedModeBanner: false,
        ),
      ),
    ),
  );
}

class MainModule extends Module {
  static const String authRoute = '/auth';
  static const String lyricsRoute = '/lyrics';
  static const String servicesRoute = '/services';
  static const String initialRoute = '/';

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(r) {
    r.module(initialRoute, module: HomeModule());
    r.module(authRoute, module: AuthModule());
    //r.child(splashRoute, child: (_) => const SplashView());
    r.module(lyricsRoute, module: LyricModule());
    r.module(servicesRoute, module: ServiceModule());
  }
}
