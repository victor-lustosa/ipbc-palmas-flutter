import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/domain/use-cases/use_cases.dart';
import '../../../lyric/infra/models/hive-dtos/database_configs_hive_dto.dart';

class DatabaseBloc extends Bloc<DatabasesEvent, DatabasesState> {
  final IUseCases databasesUseCases;

  DatabaseBloc({required this.databasesUseCases}) : super(InitialDatasourceState()) {
    on<GetDataEvent>(_getData);
    on<AddDataEvent>(_addData);
  }

  _getData(GetDataEvent event, emit) async {
    await emit.onEach<DatabaseConfigsHiveDTO?>(
      await databasesUseCases.get(event.path),
      onData: (service) {
        emit(
          SuccessfullyFetchedDataState(service),
        );
      },
      onError: (error, st) {
        emit(
          ServiceExceptionState(error.toString()),
        );
      },
    );
  }

  Future<void> _addData(AddDataEvent event, emit) async {
    databasesUseCases.add(event.path, event.data);
  }
}

@immutable
abstract class DatabasesEvent {}

class InitialEvent extends DatabasesEvent {
  InitialEvent();
}

class GetDataEvent extends DatabasesEvent {
  final String path;
  GetDataEvent({required this.path});
}

class AddDataEvent extends DatabasesEvent {
  final String path;
  final dynamic data;
  AddDataEvent({required this.path, required this.data});
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

class SuccessfullyFetchedDataState extends DatabasesState {
  final DatabaseConfigsHiveDTO entity;
  SuccessfullyFetchedDataState(this.entity);
}
