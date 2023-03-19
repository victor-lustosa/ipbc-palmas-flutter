import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../core/domain/use-cases/use_cases.dart';
import '../../infra/models/hive-dtos/service_hive_dto.dart';


class DatabaseBloc extends Bloc<DatabasesEvent, DatabasesState> {
  final IUseCases databasesUseCases;

  DatabaseBloc({required this.databasesUseCases}) : super(InitialState()) {
    on<GetDataEvent>(_getData);
  }

  Future<void> _getData(GetDataEvent event, emit) async {
    await emit.onEach<List<ServiceHiveDTO>>(
      databasesUseCases.get(event.path),
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

@immutable
abstract class DatabasesState {}

class InitialState extends DatabasesState {
  InitialState();
}

class ServiceExceptionState extends DatabasesState {
  final String message;

  ServiceExceptionState(this.message);
}

class SuccessfullyFetchedDataState extends DatabasesState {
  final List<ServiceHiveDTO> entities;
  SuccessfullyFetchedDataState(this.entities);
}
