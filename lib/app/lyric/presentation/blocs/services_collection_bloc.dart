import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../view-models/lyrics_view_model.dart';
import '../../domain/entities/collection_entity.dart';
import '../../../core/domain/use-cases/use_cases.dart';
import '../../../shared/components/utils/analytics_util.dart';

class ServicesCollectionBloc
    extends Bloc<ServicesCollectionEvent, ServicesCollectionState> {
  final IUseCases fireUseCases;
  final IUseCases hiveUseCases;
  final LyricsViewModel lyricsViewModel;
  final AnalyticsUtil analyticsUtil;
  String path = '';

  ServicesCollectionBloc(
      {required this.lyricsViewModel,
      required this.fireUseCases,
      required this.analyticsUtil,
      required this.hiveUseCases})
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
    await emit.onEach<List<CollectionEntity>>(
      await fireUseCases.get(path),
      onData: (services) {
        emit(CollectionSuccessfullyFetchedState(services));
      },
      onError: (error, st) async {
        analyticsUtil.recordError(name:'fire collection bloc', error:error,st: st);
        analyticsUtil.setCustomKey(name: 'fire collection bloc', key: 'get fire collection bloc', value:  error.toString());
        emit(ServiceExceptionState(error.toString()));
      },
    );
  }

  Future<void> _getServicesCollectionInHive(
      GetServicesCollectionInHiveEvent event, emit) async {
    await emit.onEach<List<CollectionEntity>>(
      await hiveUseCases.get('services-collection/${event.path}'),
      onData: (services) {
        emit(CollectionSuccessfullyFetchedState(services));
      },
      onError: (error, st) async {
        analyticsUtil.recordError(name:'hive collection bloc', error:error,st: st);
        analyticsUtil.setCustomKey(name: 'hive collection bloc', key: 'get hive collection bloc', value:  error.toString());
        emit(ServiceExceptionState(error.toString()));
      },
    );
  }

  Future<void> _loading(_, emit) async {
    emit(LoadingServiceState());
  }

  Future<void> _updateServicesCollectionInHive(
      UpdateServicesCollectionInHiveEvent event, emit) async {
    await hiveUseCases.update('services-collection/$path', event.entities);
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

class CollectionSuccessfullyFetchedState extends ServicesCollectionState {
  final List<CollectionEntity> entities;
  CollectionSuccessfullyFetchedState(this.entities);
}
