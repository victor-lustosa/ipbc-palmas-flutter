import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class HomeBloc extends Bloc<GenericEvent<HomeEvent>, GenericState<HomeState>>
    with ConnectivityMixin {
  final IUseCases useCases;
  final String servicesPath = 'services/createAt/false';
  final String eventPath = 'event/create_at/false';

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
    final results = await Future.wait([
      useCases.get(path: servicesPath, converter: ServicesAdapter.fromMapList),
      useCases.get(path: eventPath, converter: EventAdapter.fromMapList),
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
