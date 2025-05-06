import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:home_module/home_module.dart';


void main() async {
  //Modular.setInitialRoute(AppRoutes.servicesRoute + AppRoutes.editLyricRoute);
  Modular.setInitialRoute(AppRoutes.initialRoute);
  //Modular.setInitialRoute(AppRoutes.lyricsListRoute);
  WidgetsFlutterBinding.ensureInitialized();
  // Modular.setInitialRoute(AppRoutes.lyricsListRoute);
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

// void main() async {
//   //  Modular.setInitialRoute(ServiceModule.servicesRoute + ServiceModule.editLyricRoute);
//   //Modular.setInitialRoute(LyricModule.lyricsListRoute);
//   Modular.setInitialRoute(AuthModule.authRoute + AuthModule.loginRoute);
//   WidgetsFlutterBinding.ensureInitialized();
//   await Future.wait([
//     SupabaseDatasource.init(),
//     HiveDatasource.init(),
//   ]);
//   Bloc.observer = GenericBlocObserver();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//   ]).then(
//     (_) => runApp(
//       ModularApp(
//         module: LyricModule(),
//         child: MaterialApp.router(
//           builder: (context, Widget? child) {
//             return ScrollConfiguration(
//               behavior: NoGlowBehavior(),
//               child: child!,
//             );
//           },
//           theme: lightTheme,
//           routerConfig: Modular.routerConfig,
//           debugShowCheckedModeBanner: false,
//         ),
//       ),
//     ),
//   );
// }
