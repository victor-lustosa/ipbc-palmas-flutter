import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'app/app_widget.dart';
import 'app/ipbc_bloc_observer.dart';

void main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      await Hive.initFlutter();

      HiveDatasource.initHive();

      await Hive.openBox<HiveDatabaseConfigsDTO>('database-configs');
      await Hive.openBox<HiveCollectionDTO>('collection');
      await Hive.openBox<HiveLyricDTO>('lyrics');
      await Hive.openBox<HiveServicesDTO>('services');

      if (kDebugMode) {
        await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
      }

      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

      Bloc.observer = IpbcBlocObserver();

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]).then((_) => runApp(const AppWidget()));
    },
    (error, stackTrace) => FirebaseCrashlytics.instance.recordError(error, stackTrace),
  );
}
