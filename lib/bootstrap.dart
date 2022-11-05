import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:ipbc_palmas/app/lyric/external/datasource/lyric_firestore_datasource.dart';

import 'app/app_widget.dart';
import 'app/ibpc_bloc_observer.dart';

import 'app/lyric/infra/repositories/lyric_repository.dart';

void bootstrap({required LyricFirestoreDatasource lyricDatasource}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = IpbcBlocObserver();

  final lyricRepository = LyricRepository(datasource: lyricDatasource);

  runZonedGuarded(
    () => runApp(AppWidget(lyricRepository: lyricRepository)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
