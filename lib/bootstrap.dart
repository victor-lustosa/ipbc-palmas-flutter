import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:ipbc_palmas/app/lyric/external/datasource/lyric_firestore_datasource.dart';

import 'app/app_widget.dart';
import 'app/ibpc_bloc_observer.dart';

void bootstrap({required LyricFirestoreDatasource lyricDatasource}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = IpbcBlocObserver();

  final todosRepository = TodosRepository(todosApi: todosApi);

  runZonedGuarded(
    () => runApp(AppWidget(todosRepository: todosRepository)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
