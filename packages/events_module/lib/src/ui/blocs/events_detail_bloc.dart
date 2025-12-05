import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class EventsDetailBloc
    extends Bloc<GenericEvent<EventDetailEvent>, GenericState<EventDetailState>>
    with ConnectivityMixin {
  final IUseCases onlineUseCases;
  final IUseCases? offlineUseCases;
  List<EventEntity> eventsList = [];
  late final CreateEventStore _createEventStore;

  CreateEventStore get createEventStore => _createEventStore;

  EventsDetailBloc({
    required this.onlineUseCases,
    this.offlineUseCases,
    required CreateEventStore createEventStore,
  }) :
       _createEventStore = createEventStore,
       super(LoadingState()) {
    on<GetDataEvent<EventDetailEvent>>(_getInSupa);
    on<LoadingEvent<EventDetailEvent>>(_loading);
  }

  Future<void> _getInSupa(GetDataEvent event, emit) async {
    final response = await isConnected(context: event.context);
    if (response) {
      Future.delayed(Duration.zero, () {
        if (emit.isDone) return;
        emit(LoadingEventsState());
      });
      List<EventEntity> events = [];
      final response = await onlineUseCases.get(
        params: SchemaUtil.eventParams(extra: {'filterColumn': 'id', 'filterValue': id, 'limit': 1}),
      );
      response.fold(
        (eventsResponse) => events = EventAdapter.fromMapList(eventsResponse),
        (exception) => null,
      );
      await Future.delayed(const Duration(milliseconds: 2300));
      eventsList = events;
      if (emit.isDone) return;
      emit(DataFetchedState<EventDetailState>());
    } else {
      if (emit.isDone) return;
      emit(NoConnectionState<EventDetailState>());
    }
  }

  Future<void> _loading(_, dynamic emit) async {
    emit(LoadingState<EventDetailState>());
  }

}

@immutable
abstract class EventDetailEvent {}

@immutable
abstract class EventDetailState {}

class DeleteItemEvent extends GenericEvent<EventDetailEvent> {
  DeleteItemEvent({required this.context, this.index});

  final BuildContext context;
  final int? index;
}

@immutable
class LoadingEventsState extends GenericState<EventDetailState> {
  const LoadingEventsState();
}
