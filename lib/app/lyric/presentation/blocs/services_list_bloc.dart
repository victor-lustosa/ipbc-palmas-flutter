import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../view-models/lyrics_view_model.dart';
import '../../../core/domain/use-cases/use_cases.dart';
import '../../../shared/components/utils/analytics_util.dart';
import '../../../lyric/infra/models/firestore-dtos/services_dto.dart';

class ServicesListBloc extends Bloc<ServicesListEvent, ServicesListState> {
  final IUseCases fireUseCases;
  final IUseCases hiveUseCases;
  final LyricsViewModel lyricsViewModel;
  final String path = 'services/20';
  final AnalyticsUtil analyticsUtil;
  ServicesListBloc(
      {required this.lyricsViewModel,
      required this.fireUseCases,
      required this.analyticsUtil,
      required this.hiveUseCases})
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
    await emit.onEach<List<ServicesDTO>>(
      await fireUseCases.get(path),
      onData: (services) {
        emit(ServiceSuccessfullyFetchedState(services));
      },
      onError: (error, st) async {
        analyticsUtil.recordError(name: 'fire services bloc', error: error, st: st);
        analyticsUtil.setCustomKey(name: 'fire services bloc',key: 'get fire services bloc',value: error.toString());
        emit(ServiceExceptionState(error.toString()));
      },
    );
  }

  Future<void> _getServiceInHive(GetServiceInHiveEvent event, emit) async {
    await emit.onEach<List<ServicesDTO>>(
      await hiveUseCases.get(path),
      onData: (service) {
        emit(ServiceSuccessfullyFetchedState(service));
      },
      onError: (error, st) async {
        analyticsUtil.recordError(name: 'hive services bloc',error: error,st: st,);
        analyticsUtil.setCustomKey(name: 'hive services bloc', key:'get hive services bloc',value: error.toString());
        emit(ServiceExceptionState(error.toString()));
      },
    );
  }

  Future<void> _loading(event, emit) async {
    emit(LoadingServiceState());
  }

  Future<void> _updateServiceInHive(
      UpdateServiceInHiveEvent event, emit) async {
    await hiveUseCases.update(path, event.entities);
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

class ServiceSuccessfullyFetchedState extends ServicesListState {
  final List<ServicesDTO> entities;
  ServiceSuccessfullyFetchedState(this.entities);
}
