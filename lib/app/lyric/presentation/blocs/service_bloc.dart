import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/domain/use-cases/use_cases.dart';
import '../../domain/entities/service_entity.dart';
import '../../infra/models/hive-dtos/hive_database_configs_dto.dart';
import '../view-models/lyrics_view_model.dart';

class ServiceBloc extends Bloc<ServicesEvent, ServicesState> {
  final IUseCases fireServicesUseCases;
  final IUseCases hiveServicesUseCases;
  final LyricsViewModel lyricsViewModel;
  final String initialId = 'fdg33f345';
  late HiveDatabaseConfigsDTO data;
  bool addController = false;

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
    data = event.data;
    add(LoadingEvent());
    if (checkUpdate(event.path, data)) {
      final isConnected = await lyricsViewModel.isConnected();
      if (isConnected) {
        add(GetServiceInFireEvent(path: event.path));
      } else {
        emit(NoConnectionAvailableState());
      }
    } else {
      add(GetServiceInHiveEvent(path: event.path));
    }
  }

  checkUpdate(String path, HiveDatabaseConfigsDTO data) {
    if (!checkServiceType(path, data) || (data.hiveUpdateId != data.fireUpdateId)) {
      return true;
    } else {
      return false;
    }
  }

  bool checkServiceType(String type, HiveDatabaseConfigsDTO data) {
    switch (type) {
      case 'saturday-services':
        return data.isSaturdayCollectionUpdated;
      case 'morning-sunday-services':
        return data.isSundayMorningCollectionUpdated;
      case 'evening-sunday-services':
        return data.isSundayEveningCollectionUpdated;
      default:
        return false;
    }
  }

  Future<void> _getServiceInFire(GetServiceInFireEvent event, emit) async {
    await emit.onEach<List<ServiceEntity>>(
      await fireServicesUseCases.get(event.path),
      onData: (services) {
        add(UpdateServiceInHiveEvent(path: event.path, entities: services));
        emit(SuccessfullyFetchedServiceState(services));
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
      onData: (services) {
        emit(SuccessfullyFetchedServiceState(services));
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
    await hiveServicesUseCases.add(event.path, event.entities);
  }

  Future<void> _updateServiceInHive(
      UpdateServiceInHiveEvent event, emit) async {
    await hiveServicesUseCases.update(event.path, event.entities);
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
  final HiveDatabaseConfigsDTO data;
  CheckConnectivityEvent({required this.path, required this.data});
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
  final dynamic entities;
  UpdateServiceInHiveEvent({required this.path, required this.entities});
}

class AddServiceInHiveEvent extends ServicesEvent {
  final String path;
  final dynamic entities;
  AddServiceInHiveEvent({required this.path, required this.entities});
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
