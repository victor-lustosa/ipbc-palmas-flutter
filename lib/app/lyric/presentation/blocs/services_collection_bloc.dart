import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/domain/use-cases/use_cases.dart';
import '../../domain/entities/service_entity.dart';
import '../view-models/lyrics_view_model.dart';

class ServicesCollectionBloc
    extends Bloc<ServicesCollectionEvent, ServicesCollectionState> {

  final IUseCases fireServicesUseCases;
  final IUseCases hiveServicesUseCases;
  final LyricsViewModel lyricsViewModel;
  String path = '';

  ServicesCollectionBloc(
      {required this.lyricsViewModel,
      required this.fireServicesUseCases,
      required this.hiveServicesUseCases})
      : super(InitialState()) {
    on<GetServicesCollectionInFireEvent>(_getServicesCollectionInFire);
    on<GetServicesCollectionInHiveEvent>(_getServicesCollectionInHive);
    on<UpdateServicesCollectionInHiveEvent>(_updateServicesCollectionInHive);
    on<LoadingEvent>(_loading);
    on<CheckConnectivityEvent>(_checkConnectivity);
  }
  Future<void> _checkConnectivity(CheckConnectivityEvent event, emit) async {
    path = event.path;
    final isConnected = await lyricsViewModel.isConnected();
    if (isConnected) {
      add(GetServicesCollectionInFireEvent());
    } else {
      emit(NoConnectionAvailableState());
    }
  }

  Future<void> _getServicesCollectionInFire(
      GetServicesCollectionInFireEvent event, emit) async {
    await emit.onEach<List<ServiceEntity>>(
      await fireServicesUseCases.get(path),
      onData: (services) {
        emit(SuccessfullyFetchedCollectionState(services));
      },
      onError: (error, st) async {
        await FirebaseCrashlytics.instance.recordError(error, st, reason: 'a non-fatal error');
        FirebaseCrashlytics.instance.setCustomKey('get fire service bloc', error.toString());
        emit(ServiceExceptionState(error.toString()));
      },
    );
  }

  Future<void> _getServicesCollectionInHive(
      GetServicesCollectionInHiveEvent event, emit) async {
    await emit.onEach<List<ServiceEntity>>(
      await hiveServicesUseCases.get('services/${event.path}'),
      onData: (services) {
        emit(SuccessfullyFetchedCollectionState(services));
      },
      onError: (error, st) async {
        await FirebaseCrashlytics.instance.recordError(error, st, reason: 'a non-fatal error');
        FirebaseCrashlytics.instance.setCustomKey('get hive service bloc', error.toString());
        emit(ServiceExceptionState(error.toString()));
      },
    );
  }

  Future<void> _loading(_, emit) async {
    emit(LoadingServiceState());
  }

  Future<void> _updateServicesCollectionInHive(
      UpdateServicesCollectionInHiveEvent event, emit) async {
    await hiveServicesUseCases.update('services/$path', event.entities);
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
  CheckConnectivityEvent({required this.path});
}
class GetServicesCollectionInFireEvent extends ServicesCollectionEvent {
  GetServicesCollectionInFireEvent();
}
class GetServicesCollectionInHiveEvent extends ServicesCollectionEvent {
  final String path;
  GetServicesCollectionInHiveEvent({required this.path});
}
class UpdateServicesCollectionInHiveEvent extends ServicesCollectionEvent {
  final dynamic entities;
  UpdateServicesCollectionInHiveEvent({required this.entities});
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
