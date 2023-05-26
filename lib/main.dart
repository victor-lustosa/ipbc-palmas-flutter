import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'firebase_options.dart';
import 'app/app_widget.dart';
import 'app/ipbc_bloc_observer.dart';
import 'app/core/external/hive_datasource.dart';
import 'app/lyric/infra/models/hive-dtos/hive_lyric_dto.dart';
import 'app/lyric/infra/models/hive-dtos/hive_services_dto.dart';
import 'app/lyric/infra/models/hive-dtos/hive_collection_dto.dart';
import 'app/lyric/infra/models/hive-dtos/hive_database_configs_dto.dart';

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
