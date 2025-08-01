import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class EventsListBloc
    extends Bloc<GenericEvent<EventsListEvent>, GenericState<EventsListState>>
    with ConnectivityMixin {
  final IUseCases onlineUseCases;
  final IUseCases? offlineUseCases;
  String path = 'event/create_at/false';

  EventsListBloc({
    required this.onlineUseCases,
    this.offlineUseCases,
  }) : super(LoadingState()) {
    on<GetDataEvent<EventsListEvent>>(_getInSupa);
    on<LoadingEvent<EventsListEvent>>(_loading);
  }

  Future<void> _getInSupa(GetDataEvent event, emit) async {
    path = event.path.isNotEmpty ? event.path : path;
    final response = await isConnected();
    if (response) {
      List<EventEntity> events = await onlineUseCases.get(
          path: path, converter: EventAdapter.fromMapList);
      emit(DataFetchedState<EventsListState, List<EventEntity>>(
          entities: events));
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
