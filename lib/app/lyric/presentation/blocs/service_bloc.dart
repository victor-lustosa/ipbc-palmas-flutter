import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:ipbc_palmas/app/lyric/infra/use-cases/services_use_cases.dart';

import '../../domain/entities/service_entity.dart';
import '../../infra/models/hive-dtos/hive_database_configs_dto.dart';
import '../view-models/lyrics_view_model.dart';

class ServiceBloc extends Bloc<ServicesEvent, ServicesState> {
  final ServicesUseCases fireServicesUseCases;
  final ServicesUseCases hiveServicesUseCases;
  final LyricsViewModel lyricsViewModel;
  ServiceBloc(
      {required this.lyricsViewModel,
      required this.fireServicesUseCases,
      required this.hiveServicesUseCases})
      : super(InitialState()) {
    on<GetServiceInFireEvent>(_getServiceInFire);
    on<AddServiceInHiveEvent>(_addServiceInHive);
    on<UpdateServiceInHiveEvent>(_updateServiceInHive);
    on<GetServiceInHiveEvent>(_getServiceInHive);
    on<LoadingEvent>(_loading);
    on<CheckConnectivityEvent>(_checkConnectivity);
  }
  Future<void> _checkConnectivity(CheckConnectivityEvent event, emit) async {
    add(LoadingEvent());
    if (checkServiceType(event.path, event.database) || (event.database.hiveUpdateId != event.database.fireUpdateId)) {
      add(GetServiceInHiveEvent(path: event.path));
    } else {
      final isConnected = await lyricsViewModel.isConnected();
      if (isConnected) {
        add(GetServiceInFireEvent(path: event.path));
      } else {
        emit(NoConnectionAvailableState());
      }
    }
  }

  bool checkServiceType(String type, HiveDatabaseConfigsDTO database) {
    switch (type) {
      case 'saturday-services':
        return database.isSaturdayCollectionUpdated;
      case 'morning-sunday-services':
        return database.isSundayMorningCollectionUpdated;
      case 'evening-sunday-services':
        return database.isSundayEveningCollectionUpdated;
      default:
        return false;
    }
  }

  Future<void> _getServiceInFire(GetServiceInFireEvent event, emit) async {

    await emit.onEach<List<ServiceEntity>>(
      await fireServicesUseCases.get(event.path),
      onData: (service) {
        add(UpdateServiceInHiveEvent(path: 'services', data: service));
        emit(SuccessfullyFetchedServiceState(service));
      },
      onError: (error, st) async {
        await FirebaseCrashlytics.instance
            .recordError(error, st, reason: 'a non-fatal error');
        FirebaseCrashlytics.instance
            .setCustomKey('get fire service bloc', error.toString());
        emit(ServiceExceptionState(error.toString()));
      },
    );
  }

  Future<void> _getServiceInHive(GetServiceInHiveEvent event, emit) async {
    await emit.onEach<List<ServiceEntity>>(
      await hiveServicesUseCases.get(event.path),
      onData: (service) {
        emit(SuccessfullyFetchedServiceState(service));
      },
      onError: (error, st) async {
        await FirebaseCrashlytics.instance
            .recordError(error, st, reason: 'a non-fatal error');
        FirebaseCrashlytics.instance
            .setCustomKey('get hive service bloc', error.toString());
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
  Future<void> _updateServiceInHive(UpdateServiceInHiveEvent event, emit) async {
    await hiveServicesUseCases.update(event.path, event.data);
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
  final HiveDatabaseConfigsDTO database;
  CheckConnectivityEvent({required this.path, required this.database});
}

class GetServiceInFireEvent extends ServicesEvent {
  final String path;
  GetServiceInFireEvent({required this.path});
}

class GetServiceInHiveEvent extends ServicesEvent {
  final String path;
  GetServiceInHiveEvent({required this.path});
}
class UpdateServiceInHiveEvent extends ServicesEvent {
  final String path;
  final dynamic data;
  UpdateServiceInHiveEvent({required this.path, required this.data});
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
