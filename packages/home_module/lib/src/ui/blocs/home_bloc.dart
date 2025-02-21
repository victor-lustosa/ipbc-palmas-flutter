import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class HomeBloc extends Bloc<GenericEvent<HomeEvent>, GenericState<HomeState>>
    with ConnectivityMixin {
  final IUseCases _useCases;
  final LoginStore _loginStore;
  final String servicesPath = 'services/createAt/false';
  final String eventPath = 'event/create_at/false';

  HomeBloc({required LoginStore loginStore, required IUseCases useCases})
    : _loginStore = loginStore,
      _useCases = useCases,
      super(LoadingState()) {
    on<GetDataEvent<HomeEvent>>(_getData);
    on<CheckConnectivityEvent<HomeEvent>>(_checkConnectivity);
  }

  Future<void> _checkConnectivity(CheckConnectivityEvent event, emit) async {
    final response = await isConnected();
    if (response) {
      add(GetDataEvent<HomeEvent>());
    } else {
      emit(NoConnectionState<HomeState>());
    }
  }

  Future<void> _getData(GetDataEvent event, emit) async {
    final results = await Future.wait([
      _useCases.get(path: servicesPath, converter: ServicesAdapter.fromMapList),
      _useCases.get(path: eventPath, converter: EventAdapter.fromMapList),
    ]);
    final services = results[0];
    final events = results[1];
    final localUser = await _loginStore.getLocalUser();
    if (localUser != null) {
      emit(
        DataFetchedState<HomeState, HomeDTO>(
          entities: HomeDTO(
            servicesEntitiesList: services,
            eventEntitiesList: events,
            picture: localUser.picture,
          ),
        ),
      );
    }
  }
}

@immutable
abstract class HomeEvent {}

@immutable
abstract class HomeState {}

class HomeDTO {
  HomeDTO({
    required this.picture,
    required this.servicesEntitiesList,
    required this.eventEntitiesList,
  });

  final String picture;
  final List<ServicesEntity> servicesEntitiesList;
  final List<EventEntity> eventEntitiesList;
}
