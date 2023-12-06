import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

import '../../shared/blocs/generics.dart';
import '../../shared/view-models/services_view_model.dart';

class ServicesListBloc extends Bloc<GenericEvent<ServicesListEvent>, GenericState<ServicesListState>> {
  final IUseCases supaUseCases;
  final ServicesViewModel viewModel;
  final String path = 'services/20';
  final AnalyticsUtil analyticsUtil;

  ServicesListBloc(
      {required this.viewModel,
      required this.supaUseCases,
      required this.analyticsUtil})
      : super(LoadingState()) {
    on<GetInSupaEvent<ServicesListEvent>>(_getInSupa);
    on<CheckConnectivityEvent<ServicesListEvent>>(_checkConnectivity);
    on<LoadingEvent<ServicesListEvent>>(_loading);
  }

  Future<void> _checkConnectivity(CheckConnectivityEvent event, emit) async {
    final isConnected = await viewModel.isConnected();
    if (isConnected) {
      add(GetInSupaEvent<ServicesListEvent>());
    } else {
      emit(NoConnectionState<ServicesListState>());
    }
  }

  Future<void> _getInSupa(GetInSupaEvent event, emit) async {
    await emit.onEach<List<ServicesEntity>>(
      await supaUseCases.get(path),
      onData: (services) {
        emit(DataFetchedState<ServicesListState, ServicesEntity>(entities: services));
      },
      onError: (error, st) async {
        analyticsUtil.recordError(name: 'supa services bloc', error: error, st: st);
        analyticsUtil.setCustomKey(name: 'supa services bloc',key: 'get supa services bloc',value: error.toString());
        emit(ExceptionState<ServicesListState>(message: error.toString()));
      },
    );
  }

  Future<void> _loading(event, emit) async {
    emit(LoadingState<ServicesListState>());
  }
}

@immutable
abstract class ServicesListEvent {}

@immutable
abstract class ServicesListState {}

