import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/domain/use-cases/use_cases.dart';
import '../../domain/entities/service_entity.dart';
import '../../domain/entities/services_list_entity.dart';

class ServiceBloc extends Bloc<ServicesEvent, ServicesState> {

  final IUseCases fireServicesUseCases;
  final IUseCases hiveServicesUseCases;

  ServiceBloc({required this.fireServicesUseCases, required this.hiveServicesUseCases}) : super(InitialState()) {
    on<GetServiceInFireEvent>(_getServiceInFire);
    on<AddServiceInHiveEvent>(_addServiceInHive);
    on<GetServiceInHiveEvent>(_getServiceInHive);
  }

  Future<void> _getServiceInFire(GetServiceInFireEvent event, emit) async {
    await emit.onEach<ServicesListEntity>(
      await fireServicesUseCases.get(event.path),
      onData: (service) {
        emit(SuccessfullyFetchedServiceState(service));
      },
      onError: (error, st) {
        emit(ServiceExceptionState(error.toString()));
      },
    );
  }

  Future<void> _getServiceInHive(GetServiceInHiveEvent event, emit) async {
    await emit.onEach<ServicesListEntity>(
      await hiveServicesUseCases.get(event.path),
      onData: (service) {
        emit(SuccessfullyFetchedServiceState(service));
      },
      onError: (error, st) {
        emit(ServiceExceptionState(error.toString()));
      },
    );
  }

  Future<void> _addServiceInHive(AddServiceInHiveEvent event, emit) async {
    await hiveServicesUseCases.add(event.path, event.data);
  }
}

@immutable
abstract class ServicesEvent {}

class InitialEvent extends ServicesEvent {
  InitialEvent();
}

class GetServiceInFireEvent extends ServicesEvent {
  final String path;
  GetServiceInFireEvent({required this.path});
}

class GetServiceInHiveEvent extends ServicesEvent {
  final String path;
  GetServiceInHiveEvent({required this.path});
}

class AddServiceInHiveEvent extends ServicesEvent {
  final String path;
  final dynamic data;
  AddServiceInHiveEvent({required this.path, required this.data});
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
  final ServicesListEntity entities;
  SuccessfullyFetchedServiceState(this.entities);
}
