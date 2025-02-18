import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class EventsListBloc extends Bloc<GenericEvent<EventsListEvent>,
    GenericState<EventsListState>> with ConnectivityMixin {
  final IUseCases onlineUseCases;
  final IUseCases? offlineUseCases;
  String path = '';

  EventsListBloc({ required this.onlineUseCases, this.offlineUseCases, }) : super(LoadingState()) {
    on<GetInSupaEvent<EventsListEvent>>(_getInSupa);
    on<LoadingEvent<EventsListEvent>>(_loading);
    on<CheckConnectivityEvent<EventsListEvent>>(_checkConnectivity);
  }

  Future<void> _checkConnectivity(CheckConnectivityEvent event, emit) async {
    path = event.path;
    final response = await isConnected();
    if (response) {
      add(GetInSupaEvent<EventsListEvent>());
    } else {
      emit(NoConnectionState<EventsListState>());
    }
  }

    Future<void> _getInSupa(GetInSupaEvent event, emit) async {
     List<EventEntity> events = await onlineUseCases.get(path: path, converter: ServiceAdapter.fromMapList);
     emit(DataFetchedState<EventsListState, List<EventEntity>>(entities: events));
  }

  Future<void> _loading(_, emit) async {
    emit(LoadingState<EventsListState>());
  }
}

@immutable
abstract class EventsListEvent {}

@immutable
abstract class EventsListState {}
