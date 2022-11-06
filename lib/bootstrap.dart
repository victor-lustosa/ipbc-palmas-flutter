import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'app/app_widget.dart';
import 'app/core/external/firestore_datasource.dart';
import 'app/core/infra/repositories/repository.dart';
import 'app/ibpc_bloc_observer.dart';
import 'app/lyric/domain/entities/lyric_entity.dart';


void bootstrap({required FirestoreDatasource firestoreDatasource}) {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = IpbcBlocObserver();

  final repository = Repository<LyricEntity>(getDatasource: firestoreDatasource);

  runZonedGuarded(
    () => runApp(AppWidget(repository: repository)),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
