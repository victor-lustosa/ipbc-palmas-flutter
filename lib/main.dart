import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ipbc_palmas/app/lyric/infra/models/hive-dtos/lyric_hive_dto.dart';

import 'app/app_widget.dart';
import 'app/core/external/hive_datasource.dart';
import 'app/ibpc_bloc_observer.dart';
import 'app/lyric/infra/models/hive-dtos/database_configs_hive_dto.dart';
import 'app/lyric/infra/models/hive-dtos/service_hive_dto.dart';
import 'firebase_options.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  HiveDatasource.initHive();
  await Hive.openBox<DatabaseConfigsHiveDTO>('database-configs');
  await Hive.openBox<ServiceHiveDTO>('services');
  await Hive.openBox<LyricHiveDTO>('lyrics');
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
