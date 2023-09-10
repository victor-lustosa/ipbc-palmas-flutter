import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'src/app_widget.dart';
import 'src/home/home_module.dart';
//import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  //setUrlStrategy(PathUrlStrategy());
  runApp(
    ModularApp(
      module: MainModule(),
      child: const AppWidget(),
    ),
  );
}
