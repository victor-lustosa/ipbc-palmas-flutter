import 'dart:async';
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class DatabaseBloc extends Bloc<DatabasesEvent, DatabasesState> {
  final DatabasesUseCases useCases;
  final AnalyticsUtil analyticsUtil;
  final String path = 'database-configs';

  DatabaseBloc({required this.useCases, required this.analyticsUtil})
      : super(LoadingState()) {
    on<GetDataEvent>(_getData);
    on<UpdateDataEvent>(_updateData);
  }

  _getData(GetDataEvent event, emit) async {
     var service = await useCases.get(path);
     if(service != null){
       emit(FetchingDataState(service));
     } else {
       emit(ExceptionState('database bloc'));
      }
  }

  Future<void> _updateData(UpdateDataEvent event, emit) async {
    useCases.update(path, event.data);
  }
}

@immutable
abstract class DatabasesEvent {}

class GetDataEvent extends DatabasesEvent {
  GetDataEvent();
}

class UpdateDataEvent extends DatabasesEvent {
  final HiveDatabaseConfigsDTO data;
  UpdateDataEvent({required this.data});
}

@immutable
abstract class DatabasesState {}

class LoadingState extends DatabasesState {
  LoadingState();
}

class ExceptionState extends DatabasesState {
  final String message;
  ExceptionState(this.message);
}

class FetchingDataState extends DatabasesState {
  final HiveDatabaseConfigsDTO entity;
  FetchingDataState(this.entity);
}
