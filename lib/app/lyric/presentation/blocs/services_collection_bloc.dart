import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';

import '../../../lyric/infra/models/firestore-dtos/services_collection_dto.dart';
import '../../infra/models/hive-dtos/hive_database_configs_dto.dart';
import '../../infra/use-cases/collections_use_cases.dart';
import '../view-models/lyrics_view_model.dart';

class ServicesCollectionBloc extends Bloc<ServicesCollectionEvent, ServicesCollectionState> {

  final CollectionsUseCases fireCollectionUseCases;
  final CollectionsUseCases hiveCollectionUseCases;
  final LyricsViewModel lyricsViewModel;

  final String path = 'services-collection/id';

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
    add(LoadingEvent());
    if(event.database.isServicesUpdated || (event.database.hiveUpdateId == event.database.fireUpdateId)){
      add(GetCollectionInHiveEvent());
    } else {
      final isConnected = await lyricsViewModel.isConnected();
      if(isConnected){
        add(GetCollectionInFireEvent(database: event.database));
      } else {
        emit(NoConnectionAvailableState());
      }
    }
  }

  Future<void> _getCollectionInFire(GetCollectionInFireEvent event, emit) async {
    await emit.onEach<List<ServicesCollectionDTO>>(
      await fireCollectionUseCases.get(path),
      onData: (service) {
           add(UpdateCollectionInHiveEvent(data: service));
           emit(SuccessfullyFetchedCollectionState(service));
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
    await hiveCollectionUseCases.add(path, event.data);
  }

  Future<void> _updateCollectionInHive(UpdateCollectionInHiveEvent event, emit) async {
    await hiveCollectionUseCases.update(path, event.data);
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
  final HiveDatabaseConfigsDTO database;
  CheckConnectivityEvent({required this.database});
}
class GetCollectionInFireEvent extends ServicesCollectionEvent {
  final HiveDatabaseConfigsDTO database;
  GetCollectionInFireEvent({required this.database});
}

class GetCollectionInHiveEvent extends ServicesCollectionEvent {
  GetCollectionInHiveEvent();
}
class UpdateCollectionInHiveEvent extends ServicesCollectionEvent {
  final dynamic data;
  UpdateCollectionInHiveEvent({required this.data});
}
class AddCollectionInHiveEvent extends ServicesCollectionEvent {
  final dynamic data;
  AddCollectionInHiveEvent({required this.data});
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
