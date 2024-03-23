import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class ServicesCollectionBloc extends Bloc<GenericEvent<ServicesCollectionEvent>,
    GenericState<ServicesCollectionState>> with ConnectivityMixin {
  final IUseCases supaUseCases;
  List<String> path = [];

  ServicesCollectionBloc({required this.supaUseCases}) : super(LoadingState()) {
    on<GetInSupaEvent<ServicesCollectionEvent>>(_getInSupa);
    on<LoadingEvent<ServicesCollectionEvent>>(_loading);
    on<CheckConnectivityEvent<ServicesCollectionEvent>>(_checkConnectivity);
  }

  Future<void> _checkConnectivity(CheckConnectivityEvent event, emit) async {
    path = event.path.split('/');
    final response = await isConnected();
    if (response) {
      add(GetInSupaEvent<ServicesCollectionEvent>());
    } else {
      emit(NoConnectionState<ServicesCollectionState>());
    }
  }



  Future<void> _getInSupa(
      GetInSupaEvent<ServicesCollectionEvent> event, emit) async {
    List<ServiceEntity>? servicesCollectionList =
        await MockUtil.convertMockJson<List<ServiceEntity>>(
      'assets/mocks/${path[2]}_mock.json',
          path[2],
    );
    if (servicesCollectionList!.isNotEmpty) {
      emit(
        DataFetchedState<ServicesCollectionState, ServiceEntity>(
          entities: servicesCollectionList,
        ),
      );
    }
  }

  /*  Future<void> _getInSupa(
    GetInSupaEvent event,
    emit,
  ) async {
    await emit.onEach<List<ServiceEntity>>(
      await supaUseCases.get(path),
      onData: (services) {
        emit(
          DataFetchedState<ServicesCollectionState, ServiceEntity>(
              entities: services),
        );
      },
      onError: (error, st) async {
        AnalyticsUtil.recordError(
            name: 'supa collection bloc', error: error, st: st);
        emit(
            ExceptionState<ServicesCollectionState>(message: error.toString()));
      },
    );
  }*/

  Future<void> _loading(_, emit) async {
    emit(LoadingState<ServicesCollectionState>());
  }
}

@immutable
abstract class ServicesCollectionEvent {}

@immutable
abstract class ServicesCollectionState {}
