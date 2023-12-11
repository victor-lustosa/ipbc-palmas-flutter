import 'package:core_module/core_module.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'app/main_module.dart';
import 'app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseDatasource.init();
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
