import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'configs/app_routes.dart';
import 'splash/main_module.dart';
import 'configs/no_glow_behavior.dart';
import 'splash/views/splash_view.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: mainModule,
      child: MaterialApp(
        builder: (context, Widget? child) {
          return ScrollConfiguration(
            behavior: NoGlowBehavior(),
            child: child!,
          );
        },
        title: 'IPBC Palmas',
        theme: lightTheme,
        home: const SplashView(),
        initialRoute: "/",
        onGenerateRoute: AppRoutes.onGenerateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
