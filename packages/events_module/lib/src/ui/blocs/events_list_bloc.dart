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
    final response = await isConnected(context: event.context);
    if (response) {
      Future.delayed(Duration.zero, () {
        if (emit.isDone) return;
        emit(LoadingEventsState());
      });
      List<EventEntity> events = await onlineUseCases.get(
        params: {
          'table': 'event',
          'orderBy': 'create_at',
          'ascending': false,
        },
        converter: EventAdapter.fromMapList,
      );
      await Future.delayed(const Duration(milliseconds: 2300));
      eventsList = events;
      if (emit.isDone) return;
      emit(DataFetchedState<EventsListState>());
    } else {
      if (emit.isDone) return;
      emit(NoConnectionState<EventsListState>());
    }
  }

  Future<void> _loading(_, emit) async {
    emit(LoadingState<EventsListState>());
  }


  Future<void> _deleteItem(DeleteItemEvent event, emit) async {
    final eventEntity = eventsList[slideCardsStore.index];
    final response = await _createEventStore.delete(eventEntity, event.context);
    if (response != null) {
      eventsList.remove(eventEntity);
    }
    if (emit.isDone) return;
    emit(DataFetchedState<EventsListState>());
  }

}

@immutable
abstract class EventsListEvent {}

@immutable
abstract class EventsListState {}

class DeleteItemEvent extends GenericEvent<EventsListEvent> {
  DeleteItemEvent({ required this.context, this.index});
  final BuildContext context;
  final int? index;
}

class LoadingEventsState extends GenericState<EventsListState> {
  LoadingEventsState();
}
