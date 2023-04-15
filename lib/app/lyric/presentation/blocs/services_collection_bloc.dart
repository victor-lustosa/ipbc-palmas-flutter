import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/domain/use-cases/use_cases.dart';
import '../../domain/entities/service_entity.dart';
import '../../infra/models/hive-dtos/hive_database_configs_dto.dart';
import '../view-models/lyrics_view_model.dart';

class ServicesCollectionBloc extends Bloc<ServicesCollectionEvent, ServicesCollectionState> {
  final IUseCases fireServicesUseCases;
  final IUseCases hiveServicesUseCases;
  final LyricsViewModel lyricsViewModel;
  final String initialId = 'fdg33f345';
  late HiveDatabaseConfigsDTO data;

  ServicesCollectionBloc(
      {required this.lyricsViewModel,
      required this.fireServicesUseCases,
      required this.hiveServicesUseCases})
      : super(InitialState()) {
    on<GetServicesCollectionInFireEvent>(_getServicesCollectionInFire);
    on<GetServicesCollectionInHiveEvent>(_getServicesCollectionInHive);
    on<AddServicesCollectionInHiveEvent>(_addServicesCollectionInHive);
    on<UpdateServicesCollectionInHiveEvent>(_updateServicesCollectionInHive);
    on<LoadingEvent>(_loading);
    on<CheckConnectivityEvent>(_checkConnectivity);
  }
  Future<void> _checkConnectivity(CheckConnectivityEvent event, emit) async {
    add(LoadingEvent());
    if (!checkCollectionType(event.path, event.data)) {
      final isConnected = await lyricsViewModel.isConnected();
      if (isConnected) {
        data = event.data;
        add(GetServicesCollectionInFireEvent(path: event.path));
      } else {
        emit(NoConnectionAvailableState());
      }
    } else {
      add(GetServicesCollectionInHiveEvent(path: event.path));
    }
  }

  bool checkCollectionType(String type, HiveDatabaseConfigsDTO data) {
    List<String> params = type.split('/');
    switch (params[0]) {
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

  Future<void> _getServicesCollectionInFire(GetServicesCollectionInFireEvent event, emit) async {
    await emit.onEach<List<ServiceEntity>>(
      await fireServicesUseCases.get(event.path),
      onData: (services) {
        add(UpdateServicesCollectionInHiveEvent(path: 'services/${event.path}', entities: services));
        emit(SuccessfullyFetchedCollectionState(services));
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

  Future<void> _getServicesCollectionInHive(GetServicesCollectionInHiveEvent event, emit) async {
    await emit.onEach<List<ServiceEntity>>(
      await hiveServicesUseCases.get('services/${event.path}'),
      onData: (services) {
        emit(SuccessfullyFetchedCollectionState(services));
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

  Future<void> _addServicesCollectionInHive(AddServicesCollectionInHiveEvent event, emit) async {
    await hiveServicesUseCases.add(event.path, event.entities);
  }

  Future<void> _updateServicesCollectionInHive(
      UpdateServicesCollectionInHiveEvent event, emit) async {
    await hiveServicesUseCases.update(event.path, event.entities);
  }
}

@immutable
abstract class ServicesCollectionEvent {}

class InitialEvent extends ServicesCollectionEvent {
  InitialEvent();
}

class LoadingEvent extends ServicesCollectionEvent {
  LoadingEvent();
}

class CheckConnectivityEvent extends ServicesCollectionEvent {
  final String path;
  final HiveDatabaseConfigsDTO data;
  CheckConnectivityEvent({required this.path, required this.data});
}

class GetServicesCollectionInFireEvent extends ServicesCollectionEvent {
  final String path;
  GetServicesCollectionInFireEvent({required this.path});
}

class GetServicesCollectionInHiveEvent extends ServicesCollectionEvent {
  final String path;
  GetServicesCollectionInHiveEvent({required this.path});
}

class UpdateServicesCollectionInHiveEvent extends ServicesCollectionEvent {
  final String path;
  final dynamic entities;
  UpdateServicesCollectionInHiveEvent({required this.path, required this.entities});
}

class AddServicesCollectionInHiveEvent extends ServicesCollectionEvent {
  final String path;
  final dynamic entities;
  AddServicesCollectionInHiveEvent({required this.path, required this.entities});
}

@immutable
abstract class ServicesCollectionState {}

class LoadingServiceState extends ServicesCollectionState {
  LoadingServiceState();
}

class NoConnectionAvailableState extends ServicesCollectionState {
  NoConnectionAvailableState();
}

class InitialState extends ServicesCollectionState {
  InitialState();
}

class ServiceExceptionState extends ServicesCollectionState {
  final String message;
  ServiceExceptionState(this.message);
}

class SuccessfullyFetchedCollectionState extends ServicesCollectionState {
  final List<ServiceEntity> entities;
  SuccessfullyFetchedCollectionState(this.entities);
}
