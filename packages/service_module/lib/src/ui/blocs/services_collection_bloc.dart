import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class ServicesCollectionBloc extends Bloc<GenericEvent<ServicesCollectionEvent>, GenericState<ServicesCollectionState>> with ConnectivityMixin{
  final IUseCases supaUseCases;
  String path = '';

  ServicesCollectionBloc({required this.supaUseCases}) : super(LoadingState()) {
    on<GetInSupaEvent<ServicesCollectionEvent>>(_getInSupa);
    on<LoadingEvent<ServicesCollectionEvent>>(_loading);
    on<CheckConnectivityEvent<ServicesCollectionEvent>>(_checkConnectivity);
  }
  Future<void> _checkConnectivity(CheckConnectivityEvent event, emit) async {
    path = event.path;
    final response = await isConnected();
    if (response) {
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
        AnalyticsUtil.recordError(
            name: 'supa collection bloc', error: error, st: st);
        AnalyticsUtil.setCustomKey(
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
