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
       super(InitialState<HomeState>()) {
    on<GetDataEvent<HomeEvent>>(_getData);
    on<GetEventsDataEvent>(_getEventsData);
  }

  final IUseCases _useCases;

  List<ServicesEntity> servicesList = [];
  List<EventEntity> eventsList = [];
  final CreateEventStore _createEventStore;

  final AuthCircleAvatarStore _authCircleAvatarStore;

  CreateEventStore get createEventStore => _createEventStore;

  Future<void> _getData(GetDataEvent event, emit) async {
    await Future.wait([
      _getServicesData(event, emit),
      _getEventsData(event, emit),
    ]);
    Future.delayed(Duration.zero, () {
      _authCircleAvatarStore.validateAuthentication();
    });
  }

  Future<void> _getServicesData(dynamic event, emit) async {
    final response = await isConnected(context: event.context);
    if (response) {
      Future.delayed(Duration.zero, () {
        emit(LoadingServicesState());
      });
      final response = await _useCases.get(
        params: SchemaUtil.servicesParams(),
      );
      response.fold(
        (servicesResponse) =>
            servicesList = ServicesAdapter.fromMapList(servicesResponse),
        (exception) => toastException(
          event.context,
          'Erro ao Salvar imagem',
          'Houve um erro ao salvar a imagem, verifique sua conexão e tente novamente.',
        ),
      );
      emit(DataFetchedState<HomeState>());
    } else {
      emit(NoConnectionState<HomeState>());
    }
  }

  void toastException(BuildContext context, String message, String title) =>
      showCustomToast(
        type: .error,
        context: context,
        title: title,
        message: message,
        duration: const Duration(seconds: 1),
      );

  Future<void> _getEventsData(dynamic event, emit) async {
    final response = await isConnected(context: event.context);
    if (response) {
      Future.delayed(Duration.zero, () {
        emit(LoadingEventsState());
      });
      final response = await _useCases.get(
        params: SchemaUtil.eventParams(extra: {'limit': 5}),
      );
      response.fold(
        (eventsResponse) {
          eventsList = EventAdapter.fromMapList(eventsResponse);
          if(eventsList.isEmpty){
            emit(NotFoundState<HomeState>());
          } else {
            emit(DataFetchedState<HomeState>());
          }
        },
        (exception) => toastException(
          event.context,
          'Erro ao Salvar imagem',
          'Houve um erro ao salvar a imagem, verifique sua conexão e tente novamente.',
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

class GetEventsDataEvent extends GenericEvent<HomeEvent> {
  final BuildContext context;
  GetEventsDataEvent(this.context);
}

class LoadingServicesState extends GenericState<HomeState> {
  const LoadingServicesState();
}

class LoadingEventsState extends GenericState<HomeState> {
  const LoadingEventsState();
}
