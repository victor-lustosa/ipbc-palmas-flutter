import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

import '../../shared/blocs/generics.dart';
import '../../shared/view-models/services_view_model.dart';

class LyricBloc extends Bloc<GenericEvent<LyricEvent>, GenericState<LyricState>> {
  final ILyricsUseCases fireUseCase;
  final ILyricsUseCases hiveUseCase;
  final ServicesViewModel viewModel;
  final AnalyticsUtil analyticsUtil;
  final String path = 'lyrics/20';

  LyricBloc({
    required this.viewModel,
    required this.analyticsUtil,
    required this.fireUseCase,
    required this.hiveUseCase,
  }) : super(LoadingState<LyricState>()) {
    on<GetInFireEvent<LyricEvent>>(_getInFire);
    on<GetInHiveEvent<LyricEvent>>(_getInHive);
    on<UpdateInHiveEvent<LyricEvent>>(_updateInHive);
    on<FilterEvent<LyricEvent>>(_filter);
    on<LoadingEvent<LyricEvent>>(_loading);
    on<CheckConnectivityEvent<LyricEvent>>(_checkConnectivity);
  }

  Future<void> _checkConnectivity(
      CheckConnectivityEvent<LyricEvent> event, emit) async {
    final isConnected = await viewModel.isConnected();
    if (isConnected) {
      add(GetInFireEvent());
    } else {
      emit(NoConnectionState<LyricState>());
    }
  }

  Future<void> _getInFire(GetInFireEvent<LyricEvent> event, emit) async {
    await emit.onEach<List<LyricEntity>>(
      await fireUseCase.get(path),
      onData: (lyrics) {
        add(UpdateInHiveEvent(entities: lyrics));
        emit(DataFetchedState<LyricState, LyricEntity>(entities: lyrics));
      },
      onError: (error, st) {
        emit(ExceptionState<LyricState>(message: error.toString()));
        analyticsUtil.recordError(name: 'lyric bloc', error: error, st: st);
        analyticsUtil.setCustomKey(
            name: 'lyric bloc',
            key: 'get fire lyrics bloc',
            value: error.toString());
      },
    );
  }

  Future<void> _getInHive(GetInHiveEvent<LyricEvent> event, emit) async {
    await emit.onEach<List<LyricEntity>>(
      await hiveUseCase.get(path),
      onData: (lyrics) {
        emit(DataFetchedState<LyricState, LyricEntity>(entities: lyrics));
      },
      onError: (error, st) async {
        analyticsUtil.recordError(name: 'lyric bloc', error: error, st: st);
        analyticsUtil.setCustomKey(
            name: 'lyric bloc',
            key: 'get hive lyrics bloc',
            value: error.toString());
        emit(ExceptionState<LyricState>(message: error.toString()));
      },
    );
  }

  Future<void> _updateInHive(UpdateInHiveEvent<LyricEvent> event, emit) async {
    hiveUseCase.update(path, event.entities);
  }

  Future<void> _loading(_, emit) async {
    emit(LoadingState<LyricState>());
  }

  Future<void> _filter(FilterEvent<LyricEvent> event, emit) async {
    List<LyricEntity> lyricsList =
        await fireUseCase.lettersFilter(event.lyrics);
    emit(DataFetchedState<LyricState, LyricEntity>(entities: lyricsList));
  }
}

@immutable
abstract class LyricEvent {}

@immutable
abstract class LyricState {}

class FilterEvent<R> extends GenericEvent<R> {
  List<LyricEntity> lyrics;
  FilterEvent({required this.lyrics});
}
