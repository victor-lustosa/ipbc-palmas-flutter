import 'dart:async';
import 'package:core_module/core_module.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/foundation.dart';
import 'app/app_widget.dart';
import 'app/splash/main_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([SupabaseDatasource.init(), HiveDatasource.init()]);

  Bloc.observer = GenericBlocObserver();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (_) => runApp(
      ModularApp(
        module: MainModule(),
        child: const AppWidget(),
      ),
    ),
  );
}
