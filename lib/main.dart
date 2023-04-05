import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'dart:developer';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app/lyric/infra/models/hive-dtos/hive_lyric_dto.dart';
import 'app/app_widget.dart';
import 'app/core/external/hive_datasource.dart';
import 'app/ipbc_bloc_observer.dart';
import 'app/lyric/infra/models/hive-dtos/hive_database_configs_dto.dart';
import 'app/lyric/infra/models/hive-dtos/hive_service_dto.dart';
import 'firebase_options.dart';

void main() async {
  if (kDebugMode) {
    // Force disable Crashlytics collection while doing every day development.
    // Temporarily toggle this to true if you want to test crash reporting in your app.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }
  runZonedGuarded<Future<void>>(() async{

    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    await Hive.initFlutter();

    HiveDatasource.initHive();

    await Hive.openBox<HiveDatabaseConfigsDTO>('database-configs');
    await Hive.openBox<HiveServiceDTO>('services');
    await Hive.openBox<HiveLyricDTO>('lyrics');

    FirebaseCrashlytics.instance.crash();

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    Bloc.observer = IpbcBlocObserver();

    runApp(const AppWidget());
  },
    (error, stackTrace) => FirebaseCrashlytics.instance.recordError(error, stackTrace)
  );

}
