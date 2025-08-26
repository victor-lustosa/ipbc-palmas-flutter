import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class HomeBloc extends Bloc<GenericEvent<HomeEvent>, GenericState<HomeState>>
    with ConnectivityMixin {
  HomeBloc({
    required IUseCases useCases,
    required CreateEventStore createEventStore,
  }) : _useCases = useCases,
       _createEventStore = createEventStore,
       super(LoadingState()) {
    on<GetDataEvent<HomeEvent>>(_getData);
    on<GetEventsDataEvent>(_getEventsData);
  }

  final IUseCases _useCases;

  List<ServicesEntity> servicesList = [];
  List<EventEntity> eventsList = [];
  final CreateEventStore _createEventStore;

  get createEventStore => _createEventStore;
  final Map<String, Object> eventParams = {
    'table': 'event',
    'orderBy': 'create_at',
    'ascending': false,
    'limit': 5,
  };

  final Map<String, Object> servicesParams = {
    'table': 'services',
    'orderBy': 'createAt',
    'ascending': false,
  };

  Future<void> _getData(GetDataEvent event, emit) async {
    await Future.wait([
      _getServicesData(event, emit),
      _getEventsData(event, emit),
    ]);
  }

  Future<void> _getServicesData(_, emit) async {
    final response = await isConnected();
    if (response) {
      final List<ServicesEntity> servicesResponse = await _useCases.get(
        params: servicesParams,
        converter: ServicesAdapter.fromMapList,
      );
      servicesList = servicesResponse;
      emit(DataFetchedState<HomeState>());
    } else {
      emit(NoConnectionState<HomeState>());
    }
  }

  Future<void> _getEventsData(_, emit) async {
    final response = await isConnected();
    if (response) {
      final List<EventEntity> eventsResponse = await _useCases.get(
        params: eventParams,
        converter: EventAdapter.fromMapList,
      );
      eventsList = eventsResponse;
      emit(DataFetchedState<HomeState>());
    } else {
      emit(NoConnectionState<HomeState>());
    }
  }
}

@immutable
abstract class HomeEvent {}

@immutable
abstract class HomeState {}

class GetEventsDataEvent extends GenericEvent<HomeEvent> {
  GetEventsDataEvent();
}