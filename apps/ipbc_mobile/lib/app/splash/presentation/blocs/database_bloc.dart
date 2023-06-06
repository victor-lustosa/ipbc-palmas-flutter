import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/utils/analytics_util.dart';
import '../../../splash/infra/use-cases/databases_use_cases.dart';
import '../../../lyric/infra/models/hive-dtos/hive_database_configs_dto.dart';

class DatabaseBloc extends Bloc<DatabasesEvent, DatabasesState> {
  final DatabasesUseCases databasesUseCases;
  final AnalyticsUtil analyticsUtil;
  final String path = 'database-configs';

  DatabaseBloc({required this.databasesUseCases, required this.analyticsUtil})
      : super(InitialDatasourceState()) {
    on<GetDataEvent>(_getData);
    on<UpdateDataEvent>(_updateData);
  }

  _getData(GetDataEvent event, emit) async {
    await emit.onEach<HiveDatabaseConfigsDTO?>(
      await databasesUseCases.get(path),
      onData: (service) {
        emit(FetchingDataState(service));
      },
      onError: (error, st) async {
        analyticsUtil.recordError(error: error, st: st, name: 'database bloc');
        analyticsUtil.setCustomKey(name: 'database bloc', key: 'get database bloc',value: error.toString());
        emit(ServiceExceptionState(error.toString()));
      },
    );
  }

  Future<void> _updateData(UpdateDataEvent event, emit) async {
    databasesUseCases.update(path, event.data);
    emit(SuccessfullyFetchedDataState());
  }
}

@immutable
abstract class DatabasesEvent {}

class InitialEvent extends DatabasesEvent {
  InitialEvent();
}

class GetDataEvent extends DatabasesEvent {
  GetDataEvent();
}

class UpdateDataEvent extends DatabasesEvent {
  final HiveDatabaseConfigsDTO data;
  UpdateDataEvent({required this.data});
}

@immutable
abstract class DatabasesState {}

class InitialDatasourceState extends DatabasesState {
  InitialDatasourceState();
}

class LoadingState extends DatabasesState {
  LoadingState();
}

class ServiceExceptionState extends DatabasesState {
  final String message;
  ServiceExceptionState(this.message);
}

class FetchingDataState extends DatabasesState {
  final HiveDatabaseConfigsDTO entity;
  FetchingDataState(this.entity);
}

class SuccessfullyFetchedDataState extends DatabasesState {
  SuccessfullyFetchedDataState();
}
