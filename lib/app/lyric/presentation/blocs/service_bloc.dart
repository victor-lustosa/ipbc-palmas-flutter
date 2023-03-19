import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/domain/use-cases/use_cases.dart';
import '../../domain/entities/service_entity.dart';

class ServiceBloc extends Bloc<ServicesEvent, ServicesState> {
  final IUseCases servicesUseCases;

  ServiceBloc({required this.servicesUseCases}) : super(InitialState()) {
    on<GetServiceEvent>(_getService);
  }

  Future<void> _getService(GetServiceEvent event, emit) async {
    await emit.onEach<List<ServiceEntity>>(
      servicesUseCases.get(event.url),
      onData: (service) {
        emit(
          SuccessfullyFetchedServiceState(service),
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
abstract class ServicesEvent {}

class InitialEvent extends ServicesEvent {
  InitialEvent();
}

class GetServiceEvent extends ServicesEvent {
  final String url;
  GetServiceEvent({required this.url});
}

@immutable
abstract class ServicesState {}

class InitialState extends ServicesState {
  InitialState();
}

class ServiceExceptionState extends ServicesState {
  final String message;

  ServiceExceptionState(this.message);
}

class SuccessfullyFetchedServiceState extends ServicesState {
  final List<ServiceEntity> entities;
  SuccessfullyFetchedServiceState(this.entities);
}
