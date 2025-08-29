import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class HomeBloc extends Bloc<GenericEvent<HomeEvent>, GenericState<HomeState>>
    with ConnectivityMixin {
  HomeBloc({
    required IUseCases useCases,
    required CreateEventStore createEventStore,
    required AuthCircleAvatarStore authCircleAvatarStore,
  }) : _useCases = useCases,
       _createEventStore = createEventStore,
       _authCircleAvatarStore = authCircleAvatarStore,
       super(LoadingState()) {
    on<GetDataEvent<HomeEvent>>(_getData);
    on<GetEventsDataEvent>(_getEventsData);
  }

  final IUseCases _useCases;

  List<ServicesEntity> servicesList = [];
  List<EventEntity> eventsList = [];
  final CreateEventStore _createEventStore;
  final AuthCircleAvatarStore _authCircleAvatarStore;

  get createEventStore => _createEventStore;

  Future<void> _getData(GetDataEvent event, emit) async {
    await Future.wait([
      _getServicesData(event, emit),
      _getEventsData(event, emit),
    ]);
    Future.delayed(Duration.zero, () {
      _authCircleAvatarStore.validateAuthentication();
    });
  }

  Future<void> _getServicesData(_, emit) async {
    final response = await isConnected();
    if (response) {
      Future.delayed(Duration.zero, () {
        emit(LoadingServicesState());
      });
      final List<ServicesEntity> servicesResponse = await _useCases.get(
        params: {
          'table': 'services',
          'orderBy': 'create_at',
          'ascending': false,
        },
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
      Future.delayed(Duration.zero, () {
        emit(LoadingEventsState());
      });
      final List<EventEntity> eventsResponse = await _useCases.get(
        params: {
          'table': 'event',
          'orderBy': 'create_at',
          'ascending': false,
          'limit': 5,
        },
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

class LoadingServicesState extends GenericState<HomeState> {
  LoadingServicesState();
}

class LoadingEventsState extends GenericState<HomeState> {
  LoadingEventsState();
}
