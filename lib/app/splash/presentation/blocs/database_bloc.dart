import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/domain/use-cases/use_cases.dart';
import '../../../lyric/infra/models/hive-dtos/hive_database_configs_dto.dart';

class DatabaseBloc extends Bloc<DatabasesEvent, DatabasesState> {
  final IUseCases databasesUseCases;
  final FirebaseCrashlytics crash;
  final String path = 'database-configs';
  DatabaseBloc({required this.databasesUseCases, required this.crash}) : super(InitialDatasourceState()) {
    on<GetDataEvent>(_getData);
    on<AddDataEvent>(_addData);
    on<UpdateDataEvent>(_updateData);
  }

  _getData(GetDataEvent event, emit) async {
    await emit.onEach<HiveDatabaseConfigsDTO?>(
      await databasesUseCases.get(path),
      onData: (service) {
        emit(FetchingDataState(service));
      },
      onError: (error, st) async {
        await crash.recordError(error, st, reason: 'a non-fatal error');
        crash.setCustomKey('get database bloc', error.toString());
        emit(ServiceExceptionState(error.toString()));
      },
    );
  }
  Future<void> _addData(AddDataEvent event, emit) async {
    databasesUseCases.add(path, event.data);
    emit(SuccessfullyFetchedDataState());
  }
  Future<void> _updateData(UpdateDataEvent event, emit) async {
   if(!event.data.isSystemUpdated){
     databasesUseCases.update(path, event.data);
    }
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
class AddDataEvent extends DatabasesEvent {
  final HiveDatabaseConfigsDTO data;
  AddDataEvent({required this.data});
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
