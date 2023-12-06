import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

import '../../shared/blocs/generics.dart';
import '../../shared/view-models/services_view_model.dart';

class ServicesCollectionBloc extends Bloc<GenericEvent<ServicesCollectionEvent>,
    GenericState<ServicesCollectionState>> {
  final IUseCases supaUseCases;
  final ServicesViewModel viewModel;
  final AnalyticsUtil analyticsUtil;
  String path = '';

  ServicesCollectionBloc(
      {required this.viewModel,
      required this.supaUseCases,
      required this.analyticsUtil})
      : super(LoadingState()) {
    on<GetInSupaEvent<ServicesCollectionEvent>>(_getInSupa);
    on<LoadingEvent<ServicesCollectionEvent>>(_loading);
    on<CheckConnectivityEvent<ServicesCollectionEvent>>(_checkConnectivity);
  }
  Future<void> _checkConnectivity(CheckConnectivityEvent event, emit) async {
    path = event.path;
    final isConnected = await viewModel.isConnected();
    if (isConnected) {
      add(GetInSupaEvent<ServicesCollectionEvent>());
    } else {
      emit(NoConnectionState<ServicesCollectionState>());
    }
  }

  Future<void> _getInSupa(
    GetInSupaEvent event,
    emit,
  ) async {
    await emit.onEach<List<ServiceEntity>>(
      await supaUseCases.get(path),
      onData: (services) {
        emit(DataFetchedState<ServicesCollectionState, ServiceEntity>(entities: services));
      },
      onError: (error, st) async {
        analyticsUtil.recordError(
            name: 'supa collection bloc', error: error, st: st);
        analyticsUtil.setCustomKey(
            name: 'supa collection bloc',
            key: 'get supa collection bloc',
            value: error.toString());
        emit(
            ExceptionState<ServicesCollectionState>(message: error.toString()));
      },
    );
  }

  Future<void> _loading(_, emit) async {
    emit(LoadingState<ServicesCollectionState>());
  }
}

@immutable
abstract class ServicesCollectionEvent {}

@immutable
abstract class ServicesCollectionState {}
