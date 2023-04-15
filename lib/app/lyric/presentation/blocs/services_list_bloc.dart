import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/domain/use-cases/use_cases.dart';
import '../../../lyric/infra/models/firestore-dtos/services_collection_dto.dart';
import '../../infra/models/hive-dtos/hive_database_configs_dto.dart';
import '../view-models/lyrics_view_model.dart';

class ServicesListBloc extends Bloc<ServicesListEvent, ServicesListState> {

  final IUseCases fireServiceUseCases;
  final IUseCases hiveServiceUseCases;
  final LyricsViewModel lyricsViewModel;
  final String path = 'services-collection/id';
  final String initialId = 'fdg33f345';
  late HiveDatabaseConfigsDTO data;

  ServicesListBloc({ required this.lyricsViewModel, required this.fireServiceUseCases, required this.hiveServiceUseCases})
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
    if(!event.data.isServicesUpdated){
      final isConnected = await lyricsViewModel.isConnected();
      if(isConnected){
        add(GetServiceInFireEvent());
      } else {
        emit(NoConnectionAvailableState());
      }
    } else {
      add(GetServiceInHiveEvent());
    }
  }

  Future<void> _getServiceInFire(GetServiceInFireEvent event, emit) async {
    await emit.onEach<List<ServicesCollectionDTO>>(
      await fireServiceUseCases.get(path),
      onData: (services) {
          add(UpdateServiceInHiveEvent(entities: services));
          emit(SuccessfullyFetchedServiceState(services));
      },
      onError: (error, st) async {
        await FirebaseCrashlytics.instance.recordError(error, st, reason: 'a non-fatal error');
        FirebaseCrashlytics.instance.setCustomKey('get fire collection bloc', error.toString());
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
        await FirebaseCrashlytics.instance.recordError(error, st, reason: 'a non-fatal error');
        FirebaseCrashlytics.instance.setCustomKey('get hive collection bloc', error.toString());
        emit(ServiceExceptionState(error.toString()));
      },
    );
  }

  Future<void> _loading(event, emit) async {
   emit(LoadingServiceState());
  }

  Future<void> _addServiceInHive(AddServiceInHiveEvent event, emit) async {
    await hiveServiceUseCases.add(path, event.entities);
  }

  Future<void> _updateServiceInHive(UpdateServiceInHiveEvent event, emit) async {
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
  final HiveDatabaseConfigsDTO data;
  CheckConnectivityEvent({required this.data});
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
class AddServiceInHiveEvent extends ServicesListEvent {
  final dynamic entities;
  AddServiceInHiveEvent({required this.entities});
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
