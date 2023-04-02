import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'dart:developer';

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

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  HiveDatasource.initHive();

  await Hive.openBox<HiveDatabaseConfigsDTO>('database-configs');
  await Hive.openBox<HiveServiceDTO>('services');
  await Hive.openBox<HiveLyricDTO>('lyrics');

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (details) {
    log(
      details.exceptionAsString(),
      stackTrace: details.stack,
    );
  };

  Bloc.observer = IpbcBlocObserver();

  runZonedGuarded(
    () => runApp(const AppWidget()),
    (error, stackTrace) => log(
      error.toString(),
      stackTrace: stackTrace,
    ),
  );
}
