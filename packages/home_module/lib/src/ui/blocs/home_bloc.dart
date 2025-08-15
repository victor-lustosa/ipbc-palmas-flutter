import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class HomeBloc extends Bloc<GenericEvent<HomeEvent>, GenericState<HomeState>>
    with ConnectivityMixin {

  final IUseCases _useCases;

  final Map<String, Object> eventParams = {
    'table': 'event',
    'orderBy': 'create_at',
    'ascending': false,
  };

  final Map<String, Object> servicesParams = {
    'table': 'services',
    'orderBy': 'createAt',
    'ascending': false,
  };

  HomeBloc({required IUseCases useCases})
    : _useCases = useCases,
      super(LoadingState()) {
    on<GetDataEvent<HomeEvent>>(_getData);
  }

  Future<void> _getData(GetDataEvent event, emit) async {
    final response = await isConnected();
    if (response) {
      final results = await Future.wait([
        _useCases.get(
          params: servicesParams,
          converter: ServicesAdapter.fromMapList,
        ),
        _useCases.get(
          params: eventParams,
          converter: EventAdapter.fromMapList,
        ),
      ]);
      final services = results[0];
      final events = results[1];
      emit(
        DataFetchedState<HomeState, HomeDTO>(
          entities: HomeDTO(
            servicesEntitiesList: services,
            eventEntitiesList: events,
          ),
        ),
      );
    } else {
      emit(NoConnectionState<HomeState>());
    }
  }
}

@immutable
abstract class HomeEvent {}

@immutable
abstract class HomeState {}

class HomeDTO {
  HomeDTO({
    required this.servicesEntitiesList,
    required this.eventEntitiesList,
  });

  final List<ServicesEntity> servicesEntitiesList;
  final List<EventEntity> eventEntitiesList;
}
