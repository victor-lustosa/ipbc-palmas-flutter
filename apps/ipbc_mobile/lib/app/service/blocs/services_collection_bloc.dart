import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

import '../../shared/blocs/generics.dart';
import '../../shared/view-models/services_view_model.dart';

class ServicesCollectionBloc extends Bloc<GenericEvent<ServicesCollectionEvent>, GenericState<ServicesCollectionState>> {
  final IUseCases fireUseCases;
  final IUseCases hiveUseCases;
  final ServicesViewModel viewModel;
  final AnalyticsUtil analyticsUtil;
  String path = '';

  ServicesCollectionBloc(
      {required this.viewModel,
      required this.fireUseCases,
      required this.analyticsUtil,
      required this.hiveUseCases})
      : super(LoadingState()) {
    on<GetInFireEvent<ServicesCollectionEvent>>(_getServicesCollectionInFire);
    on<GetInHiveEvent<ServicesCollectionEvent>>(_getServicesCollectionInHive);
    on<UpdateInHiveEvent<ServicesCollectionEvent>>(_updateServicesCollectionInHive);
    on<LoadingEvent<ServicesCollectionEvent>>(_loading);
    on<CheckConnectivityEvent<ServicesCollectionEvent>>(_checkConnectivity);
  }
  Future<void> _checkConnectivity(CheckConnectivityEvent event, emit) async {
    path = event.path;
    final isConnected = await viewModel.isConnected();
    if (isConnected) {
      add(GetInFireEvent<ServicesCollectionEvent>());
    } else {
      emit(NoConnectionState<ServicesCollectionState>());
    }
  }

  Future<void> _getServicesCollectionInFire(
      GetInFireEvent event, emit) async {
    await emit.onEach<List<ServiceEntity>>(
      await fireUseCases.get(path),
      onData: (services) {
        if (services.isNotEmpty && (services[0].type == path.split('/')[0])) {
          add(UpdateInHiveEvent<ServicesCollectionEvent>(entities: services));
        }
        emit(DataFetchedState(entities: services));
      },
      onError: (error, st) async {
        analyticsUtil.recordError(
            name: 'fire collection bloc', error: error, st: st);
        analyticsUtil.setCustomKey(
            name: 'fire collection bloc',
            key: 'get fire collection bloc',
            value: error.toString());
        emit(ExceptionState(message: error.toString()));
      },
    );
  }

  Future<void> _getServicesCollectionInHive(
      GetInHiveEvent event, emit) async {
    await emit.onEach<List<ServiceEntity>>(
      await hiveUseCases.get('services-collection/${event.path}'),
      onData: (services) {
        emit(DataFetchedState(entities: services));
      },
      onError: (error, st) async {
        analyticsUtil.recordError(
            name: 'hive collection bloc', error: error, st: st);
        analyticsUtil.setCustomKey(
            name: 'hive collection bloc',
            key: 'get hive collection bloc',
            value: error.toString());
        emit(ExceptionState(message: error.toString()));
      },
    );
  }

  Future<void> _loading(_, emit) async {
    emit(LoadingState());
  }

  Future<void> _updateServicesCollectionInHive(
      UpdateInHiveEvent<ServicesCollectionEvent> event, emit) async {
    await hiveUseCases.update('services-collection/$path', event.entities);
  }
}

@immutable
abstract class ServicesCollectionEvent {}

@immutable
abstract class ServicesCollectionState {}
