import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app/app_widget.dart';
import 'app/ibpc_bloc_observer.dart';
import 'app/shared/components/splash/infra/models/hive-dtos/database_configs_hive_dto.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(
    DatabaseConfigsHiveDTOAdapter(),
  );
  await Hive.openBox<DatabaseConfigsHiveDTO>('database_configs');
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
