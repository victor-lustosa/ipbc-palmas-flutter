import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import '../../../core/domain/use-cases/use_cases.dart';
import '../../domain/entities/service_entity.dart';
import '../view-models/lyrics_view_model.dart';

class ServiceBloc extends Bloc<ServicesEvent, ServicesState> {
  final IUseCases fireServicesUseCases;
  final IUseCases hiveServicesUseCases;
  final LyricsViewModel lyricsViewModel;
  ServiceBloc(
      { required this.lyricsViewModel, required this.fireServicesUseCases, required this.hiveServicesUseCases})
      : super(InitialState()) {
    on<GetServiceInFireEvent>(_getServiceInFire);
    on<AddServiceInHiveEvent>(_addServiceInHive);
    on<GetServiceInHiveEvent>(_getServiceInHive);
    on<LoadingEvent>(_loading);
    on<CheckConnectivityEvent>(_checkConnectivity);
  }

  Future<void> _getServiceInFire(GetServiceInFireEvent event, emit) async {
    add(LoadingEvent());
    await emit.onEach<List<ServiceEntity>>(
      await fireServicesUseCases.get(event.path),
      onData: (service) {

      /*for(ServiceEntity entity in service){
            add(AddServiceInHiveEvent(path: 'services/${entity.type}', data: entity));
         }*/
        emit(SuccessfullyFetchedServiceState(service));
      },
      onError: (error, st) async {
        await FirebaseCrashlytics.instance.recordError(error, st, reason: 'a non-fatal error');
        emit(ServiceExceptionState(error.toString()));
      },
    );
  }
  Future<void> _checkConnectivity(CheckConnectivityEvent event, emit) async {
    final isConnected = await lyricsViewModel.isConnected();
    if(isConnected){
      add(GetServiceInFireEvent(path: event.path));
    } else {
      emit(NoConnectionAvailableState());
    }
  }
  Future<void> _getServiceInHive(GetServiceInHiveEvent event, emit) async {
    add(LoadingEvent());
    await emit.onEach<List<ServiceEntity>>(
      await hiveServicesUseCases.get(event.path),
      onData: (service) {
        emit(SuccessfullyFetchedServiceState(service));
      },
      onError: (error, st) async {
        await FirebaseCrashlytics.instance.recordError(error, st, reason: 'a non-fatal error');
        emit(ServiceExceptionState(error.toString()));
      },
    );
  }
  Future<void> _loading(_, emit) async {
   emit(LoadingServiceState());
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
class LoadingEvent extends ServicesEvent {
  LoadingEvent();
}
class CheckConnectivityEvent extends ServicesEvent {
  final String path;
  CheckConnectivityEvent({required this.path});
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
class LoadingServiceState extends ServicesState {
  LoadingServiceState();
}
class NoConnectionAvailableState extends ServicesState {
  NoConnectionAvailableState();
}
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
