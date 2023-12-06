import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import 'main_module.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Modular.setInitialRoute(MainModule.initRoute);

    return MaterialApp.router(
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
    );
  }
}
