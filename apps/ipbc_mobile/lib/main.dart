import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:home_module/home_module.dart';

void main() async {
  Modular.setInitialRoute(AppRoutes.initialRoute);
 //Modular.setInitialRoute(AppRoutes.servicesRoute + AppRoutes.editLyricRoute);
 //Modular.setInitialRoute(AppRoutes.lyricsListRoute);
 //Modular.setInitialRoute(AppRoutes.authRoute + AppRoutes.loginRoute);

  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([SupabaseRepository.init(), IsarRepository.init(),  initializeDateFormatting('pt_BR', null)]);
  // Bloc.observer = GenericBlocObserver();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(
      ModularApp(
         module: InitModule(),
        //   module: LyricModule(),
        child: MaterialApp.router(
          builder: (context, Widget? child) {
            return ScrollConfiguration(
              behavior: NoGlowBehavior(),
              child: child!,
            );
          },
          theme: lightTheme,
          locale: const Locale('pt', 'BR'),
          supportedLocales: const [
            Locale('pt', 'BR'),
          ],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routerConfig: Modular.routerConfig,
          debugShowCheckedModeBanner: false,
        ),
      ),
    ),
  );
}
