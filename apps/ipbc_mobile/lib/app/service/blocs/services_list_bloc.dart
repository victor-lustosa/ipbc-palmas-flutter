import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

import '../../shared/blocs/generics.dart';
import '../../shared/view-models/services_view_model.dart';

class ServicesListBloc extends Bloc<GenericEvent<ServicesListEvent>, GenericState<ServicesListState>> {
  final IUseCases fireUseCases;
  final IUseCases hiveUseCases;
  final ServicesViewModel viewModel;
  final String path = 'services/20';
  final AnalyticsUtil analyticsUtil;
  ServicesListBloc(
      {required this.viewModel,
      required this.fireUseCases,
      required this.analyticsUtil,
      required this.hiveUseCases})
      : super(LoadingState()) {
    on<GetInFireEvent<ServicesListEvent>>(_getInFire);
    on<UpdateInHiveEvent<ServicesListEvent>>(_updateInHive);
    on<GetInHiveEvent<ServicesListEvent>>(_getInHive);
    on<CheckConnectivityEvent<ServicesListEvent>>(_checkConnectivity);
    on<LoadingEvent<ServicesListEvent>>(_loading);
  }

  Future<void> _checkConnectivity(CheckConnectivityEvent event, emit) async {
    final isConnected = await viewModel.isConnected();
    if (isConnected) {
      add(GetInFireEvent());
    } else {
      emit(NoConnectionState());
    }
  }

  Future<void> _getInFire(GetInFireEvent event, emit) async {
    await emit.onEach<List<ServicesEntity>>(
      await fireUseCases.get(path),
      onData: (services) {
        add(UpdateInHiveEvent(entities: services));
        emit(DataFetchedState(entities: services));
      },
      onError: (error, st) async {
        analyticsUtil.recordError(name: 'fire services bloc', error: error, st: st);
        analyticsUtil.setCustomKey(name: 'fire services bloc',key: 'get fire services bloc',value: error.toString());
        emit(ExceptionState(message: error.toString()));
      },
    );
  }

  Future<void> _getInHive(GetInHiveEvent event, emit) async {
    await emit.onEach<List<ServicesEntity>>(
      await hiveUseCases.get(path),
      onData: (service) {
        emit(DataFetchedState(entities: service));
      },
      onError: (error, st) async {
        analyticsUtil.recordError(name: 'hive services bloc',error: error,st: st,);
        analyticsUtil.setCustomKey(name: 'hive services bloc', key:'get hive services bloc',value: error.toString());
        emit(ExceptionState(message: error.toString()));
      },
    );
  }

  Future<void> _loading(event, emit) async {
    emit(LoadingState());
  }

  Future<void> _updateInHive(
      UpdateInHiveEvent event, emit) async {
    await hiveUseCases.update(path, event.entities);
  }
}

@immutable
abstract class ServicesListEvent {}

@immutable
abstract class ServicesListState {}

