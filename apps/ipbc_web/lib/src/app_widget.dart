import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
        title: 'Presbiteriana Central Palmas',
        theme: lightTheme,
        routerConfig: Modular.routerConfig,
        debugShowCheckedModeBanner: false,
        );
  }
}