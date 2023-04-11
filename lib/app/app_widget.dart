
import 'package:flutter/material.dart';
import 'splash/main_module.dart';
import 'splash/presentation/views/splash_view.dart';
//import 'package:upgrader/upgrader.dart';
import 'shared/configs/no_glow_behavior.dart';
import 'shared/configs/app_configs.dart';
import 'shared/configs/app_routes.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...mainModule,
      ],
      child: MaterialApp(
        builder: (context, Widget? child) {
          return ScrollConfiguration(
            behavior: NoGlowBehavior(),
            child: child!,
          );
        },
        title: 'IPBC Palmas',
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          scaffoldBackgroundColor: AppColors.white,
          primaryColor: AppColors.white,
        ),
        home: const SplashView(),
        initialRoute: "/",
        onGenerateRoute: AppRoutes.onGenerateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
