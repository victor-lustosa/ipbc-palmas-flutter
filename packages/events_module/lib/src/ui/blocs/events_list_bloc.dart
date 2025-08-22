import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class EventsListBloc
    extends Bloc<GenericEvent<EventsListEvent>, GenericState<EventsListState>>
    with ConnectivityMixin {
  final IUseCases onlineUseCases;
  final IUseCases? offlineUseCases;
  List<EventEntity> eventsList = [];
  final Map<String, Object> eventParams = {
    'table': 'event',
    'orderBy': 'create_at',
    'ascending': false,
  };

  EventsListBloc({required this.onlineUseCases, this.offlineUseCases})
    : super(LoadingState()) {
    on<GetDataEvent<EventsListEvent>>(_getInSupa);
    on<LoadingEvent<EventsListEvent>>(_loading);
  }

  Future<void> _getInSupa(GetDataEvent event, emit) async {
    final response = await isConnected();
    if (response) {
      List<EventEntity> events = await onlineUseCases.get(
        params: eventParams,
        converter: EventAdapter.fromMapList,
      );
      eventsList = events;
      emit(DataFetchedState<EventsListState>());
    } else {
      emit(NoConnectionState<EventsListState>());
    }
  }

  Future<void> _loading(_, emit) async {
    emit(LoadingState<EventsListState>());
  }
}

@immutable
abstract class EventsListEvent {}

@immutable
abstract class EventsListState {}
