import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';


class HomeBloc extends Bloc<GenericEvent<HomeEvent>, GenericState<HomeState>> with ConnectivityMixin{
  final IUseCases supaUseCases;
  final String path = 'services/createAt/true';

  HomeBloc({required this.supaUseCases})
      : super(LoadingState()) {
    on<GetInSupaEvent<HomeEvent>>(_getInSupa);
    on<CheckConnectivityEvent<HomeEvent>>(_checkConnectivity);
    on<LoadingEvent<HomeEvent>>(_loading);
  }

  Future<void> _checkConnectivity(CheckConnectivityEvent event, emit) async {
    final response = await isConnected();
    if (response) {
      add(GetInSupaEvent<HomeEvent>());
    } else {
      emit(NoConnectionState<HomeState>());
    }
  }

  Future<void> _getInSupa(GetInSupaEvent event, emit) async {
    await emit.onEach<List<ServicesEntity>>(
      await supaUseCases.get(path),
      onData: (services) {
        emit(DataFetchedState<HomeState, ServicesEntity>(entities: services));
      },
      onError: (error, st) async {
        AnalyticsUtil.recordError(name: 'supa services bloc', error: error, st: st);
        AnalyticsUtil.setCustomKey(name: 'supa services bloc',key: 'get supa services bloc',value: error.toString());
        emit(ExceptionState<HomeState>(message: error.toString()));
      },
    );
  }

  Future<void> _loading(event, emit) async {
    emit(LoadingState<HomeState>());
  }
}

@immutable
abstract class HomeEvent {}

@immutable
abstract class HomeState {}

