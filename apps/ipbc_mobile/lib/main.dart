import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:home_module/home_module.dart';

void main() async {
  //  Modular.setInitialRoute(ServiceModule.servicesRoute + ServiceModule.editLyricRoute);
  Modular.setInitialRoute(SplashModule.splashRoute);
  // Modular.setInitialRoute(AuthModule.authRoute + AuthModule.resetPasswordRoute);
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    SupabaseDatasource.init(),
    HiveDatasource.init(),
  ]);
  Bloc.observer = GenericBlocObserver();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then(
    (_) => runApp(
      ModularApp(
        module: SplashModule(),
        child: MaterialApp.router(
          builder: (context, Widget? child) {
            return ScrollConfiguration(
              behavior: NoGlowBehavior(),
              child: child!,
            );
          },
          theme: lightTheme,
          routerConfig: Modular.routerConfig,
          debugShowCheckedModeBanner: false,
        ),
      ),
    ),
  );
}



