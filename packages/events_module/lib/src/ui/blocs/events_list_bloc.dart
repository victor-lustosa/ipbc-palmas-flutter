import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';


class EventsListBloc
    extends Bloc<GenericEvent<EventsListEvent>, GenericState<EventsListState>>
    with ConnectivityMixin {
  final IUseCases onlineUseCases;
  final IUseCases? offlineUseCases;
  List<EventEntity> eventsList = [];
  late final SlideCardsStore _slideCardsStore;
  late final CreateEventStore _createEventStore;
  get slideCardsStore => _slideCardsStore;
   CreateEventStore get createEventStore => _createEventStore;
  final Map<String, Object> eventParams = {
    'table': 'event',
    'orderBy': 'create_at',
    'ascending': false,
  };

  EventsListBloc({
    required this.onlineUseCases,
    this.offlineUseCases,
    required SlideCardsStore slideCardsStore,
    required CreateEventStore createEventStore,
  }) : _slideCardsStore = slideCardsStore,
       _createEventStore = createEventStore,
       super(LoadingState()) {
    on<GetDataEvent<EventsListEvent>>(_getInSupa);
    on<LoadingEvent<EventsListEvent>>(_loading);
    on<DeleteItemEvent>(_deleteItem);

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


  Future<void> _deleteItem(_, emit) async {
    final event = eventsList[slideCardsStore.index];
    final response = await _createEventStore.delete(event);
    if (response != null) {
      eventsList.remove(event);
    }
    emit(DataFetchedState<EventsListState>());
  }

}

@immutable
abstract class EventsListEvent {}

@immutable
abstract class EventsListState {}

class DeleteItemEvent extends GenericEvent<EventsListEvent> {
  DeleteItemEvent({ this.index});

  final int? index;
}