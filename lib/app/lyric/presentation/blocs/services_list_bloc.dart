import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/domain/use-cases/use_cases.dart';
import '../../../lyric/infra/models/firestore-dtos/services_collection_dto.dart';
import '../view-models/lyrics_view_model.dart';

class ServicesListBloc extends Bloc<ServicesListEvent, ServicesListState> {
  final IUseCases fireServiceUseCases;
  final IUseCases hiveServiceUseCases;
  final LyricsViewModel lyricsViewModel;
  final String path = 'services-collection/id';

  ServicesListBloc(
      {required this.lyricsViewModel,
      required this.fireServiceUseCases,
      required this.hiveServiceUseCases})
      : super(InitialState()) {
    on<GetServiceInFireEvent>(_getServiceInFire);
    on<UpdateServiceInHiveEvent>(_updateServiceInHive);
    on<GetServiceInHiveEvent>(_getServiceInHive);
    on<CheckConnectivityEvent>(_checkConnectivity);
    on<LoadingEvent>(_loading);
  }

  Future<void> _checkConnectivity(CheckConnectivityEvent event, emit) async {
    final isConnected = await lyricsViewModel.isConnected();
    if (isConnected) {
      add(GetServiceInFireEvent());
    } else {
      emit(NoConnectionAvailableState());
    }
  }

  Future<void> _getServiceInFire(GetServiceInFireEvent event, emit) async {
    await emit.onEach<List<ServicesCollectionDTO>>(
      await fireServiceUseCases.get(path),
      onData: (services) {
        emit(SuccessfullyFetchedServiceState(services));
      },
      onError: (error, st) async {
        await FirebaseCrashlytics.instance
            .recordError(error, st, reason: 'a non-fatal error');
        FirebaseCrashlytics.instance
            .setCustomKey('get fire collection bloc', error.toString());
        emit(ServiceExceptionState(error.toString()));
      },
    );
  }

  Future<void> _getServiceInHive(GetServiceInHiveEvent event, emit) async {
    await emit.onEach<List<ServicesCollectionDTO>>(
      await hiveServiceUseCases.get(path),
      onData: (service) {
        emit(SuccessfullyFetchedServiceState(service));
      },
      onError: (error, st) async {
        await FirebaseCrashlytics.instance
            .recordError(error, st, reason: 'a non-fatal error');
        FirebaseCrashlytics.instance
            .setCustomKey('get hive collection bloc', error.toString());
        emit(ServiceExceptionState(error.toString()));
      },
    );
  }

  Future<void> _loading(event, emit) async {
    emit(LoadingServiceState());
  }

  Future<void> _updateServiceInHive(
      UpdateServiceInHiveEvent event, emit) async {
    await hiveServiceUseCases.update(path, event.entities);
  }
}

@immutable
abstract class ServicesListEvent {}

class InitialEvent extends ServicesListEvent {
  InitialEvent();
}

class LoadingEvent extends ServicesListEvent {
  LoadingEvent();
}

class CheckConnectivityEvent extends ServicesListEvent {
  CheckConnectivityEvent();
}

class GetServiceInFireEvent extends ServicesListEvent {
  GetServiceInFireEvent();
}

class GetServiceInHiveEvent extends ServicesListEvent {
  GetServiceInHiveEvent();
}

class UpdateServiceInHiveEvent extends ServicesListEvent {
  final dynamic entities;
  UpdateServiceInHiveEvent({required this.entities});
}

@immutable
abstract class ServicesListState {}

class LoadingServiceState extends ServicesListState {
  LoadingServiceState();
}

class NoConnectionAvailableState extends ServicesListState {
  NoConnectionAvailableState();
}

class InitialState extends ServicesListState {
  InitialState();
}

class ServiceExceptionState extends ServicesListState {
  final String message;
  ServiceExceptionState(this.message);
}

class SuccessfullyFetchedServiceState extends ServicesListState {
  final List<ServicesCollectionDTO> entities;
  SuccessfullyFetchedServiceState(this.entities);
}
