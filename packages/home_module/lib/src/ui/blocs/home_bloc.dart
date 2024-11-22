import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class HomeBloc extends Bloc<GenericEvent<HomeEvent>, GenericState<HomeState>>
    with ConnectivityMixin {
  final IUseCases useCases;
  final String path = 'services/createAt/false';

  HomeBloc({required this.useCases}) : super(LoadingState()) {
    on<GetInSupaEvent<HomeEvent>>(_getInSupa);
    on<CheckConnectivityEvent<HomeEvent>>(_checkConnectivity);
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
    final services = await useCases.get(path: path, converter: ServicesAdapter.fromMapList);
    emit(DataFetchedState<HomeState, ServicesEntity>(entities: services));
  }
}

@immutable
abstract class HomeEvent {}

@immutable
abstract class HomeState {}
