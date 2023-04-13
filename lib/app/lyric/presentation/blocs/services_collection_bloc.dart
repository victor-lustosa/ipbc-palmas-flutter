import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/domain/use-cases/use_cases.dart';
import '../../../lyric/infra/models/firestore-dtos/services_collection_dto.dart';
import '../../infra/models/hive-dtos/hive_database_configs_dto.dart';
import '../view-models/lyrics_view_model.dart';

class ServicesCollectionBloc extends Bloc<ServicesCollectionEvent, ServicesCollectionState> {

  final IUseCases fireCollectionUseCases;
  final IUseCases hiveCollectionUseCases;
  final LyricsViewModel lyricsViewModel;
  final String path = 'services-collection/id';
  final String initialId = 'fdg33f345';
  late HiveDatabaseConfigsDTO data;
  bool addController = false;

  ServicesCollectionBloc({ required this.lyricsViewModel, required this.fireCollectionUseCases, required this.hiveCollectionUseCases})
      : super(InitialState()) {
    on<GetCollectionInFireEvent>(_getCollectionInFire);
    on<AddCollectionInHiveEvent>(_addCollectionInHive);
    on<UpdateCollectionInHiveEvent>(_updateCollectionInHive);
    on<GetCollectionInHiveEvent>(_getCollectionInHive);
    on<LoadingEvent>(_loading);
    on<CheckConnectivityEvent>(_checkConnectivity);
  }

  Future<void> _checkConnectivity(CheckConnectivityEvent event, emit) async {
    data = event.data;
    add(LoadingEvent());
    if(checkUpdate(data)){
      final isConnected = await lyricsViewModel.isConnected();
      if(isConnected){
        add(GetCollectionInFireEvent());
      } else {
        emit(NoConnectionAvailableState());
      }
    } else {
      add(GetCollectionInHiveEvent());
    }
  }
  checkUpdate(HiveDatabaseConfigsDTO data){
    if(!data.isServicesUpdated || (data.hiveUpdateId != data.fireUpdateId)) {
      return true;
    } else{
      return false;
    }
  }
  Future<void> _getCollectionInFire(GetCollectionInFireEvent event, emit) async {
    await emit.onEach<List<ServicesCollectionDTO>>(
      await fireCollectionUseCases.get(path),
      onData: (services) {
          add(UpdateCollectionInHiveEvent(entities: services));
          emit(SuccessfullyFetchedCollectionState(services));
      },
      onError: (error, st) async {
        await FirebaseCrashlytics.instance.recordError(error, st, reason: 'a non-fatal error');
        FirebaseCrashlytics.instance.setCustomKey('get fire collection bloc', error.toString());
        emit(CollectionExceptionState(error.toString()));
      },
    );
  }

  Future<void> _getCollectionInHive(GetCollectionInHiveEvent event, emit) async {
    await emit.onEach<List<ServicesCollectionDTO>>(
      await hiveCollectionUseCases.get(path),
      onData: (service) {
        emit(SuccessfullyFetchedCollectionState(service));
      },
      onError: (error, st) async {
        await FirebaseCrashlytics.instance.recordError(error, st, reason: 'a non-fatal error');
        FirebaseCrashlytics.instance.setCustomKey('get hive collection bloc', error.toString());
        emit(CollectionExceptionState(error.toString()));
      },
    );
  }

  Future<void> _loading(event, emit) async {
   emit(LoadingCollectionState());
  }

  Future<void> _addCollectionInHive(AddCollectionInHiveEvent event, emit) async {
    await hiveCollectionUseCases.add(path, event.entities);
  }

  Future<void> _updateCollectionInHive(UpdateCollectionInHiveEvent event, emit) async {
    await hiveCollectionUseCases.update(path, event.entities);
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
  final HiveDatabaseConfigsDTO data;
  CheckConnectivityEvent({required this.data});
}
class GetCollectionInFireEvent extends ServicesCollectionEvent {
  GetCollectionInFireEvent();
}

class GetCollectionInHiveEvent extends ServicesCollectionEvent {
  GetCollectionInHiveEvent();
}
class UpdateCollectionInHiveEvent extends ServicesCollectionEvent {
  final dynamic entities;
  UpdateCollectionInHiveEvent({required this.entities});
}
class AddCollectionInHiveEvent extends ServicesCollectionEvent {
  final dynamic entities;
  AddCollectionInHiveEvent({required this.entities});
}

@immutable
abstract class ServicesCollectionState {}
class LoadingCollectionState extends ServicesCollectionState {
  LoadingCollectionState();
}
class NoConnectionAvailableState extends ServicesCollectionState {
  NoConnectionAvailableState();
}
class InitialState extends ServicesCollectionState {
  InitialState();
}

class CollectionExceptionState extends ServicesCollectionState {
  final String message;
  CollectionExceptionState(this.message);
}

class SuccessfullyFetchedCollectionState extends ServicesCollectionState {
  final List<ServicesCollectionDTO> entities;
  SuccessfullyFetchedCollectionState(this.entities);
}
