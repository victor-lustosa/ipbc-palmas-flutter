import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'app/app_widget.dart';
import 'app/configs/ipbc_bloc_observer.dart';
import 'app/splash/main_module.dart';

class GInstances{
  static GetIt getIt = GetIt.instance;
}

void main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Future.wait([
        Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
        HiveDatasource.hiveInit()
      ]);

      if (kDebugMode) {
        await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
      }

      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      Bloc.observer = IpbcBlocObserver();

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
    },
    (error, stackTrace) => FirebaseCrashlytics.instance.recordError(error, stackTrace),
  );
}
