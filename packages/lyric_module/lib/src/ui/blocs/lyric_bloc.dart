import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class LyricBloc extends Bloc<GenericEvent<LyricEvent>, GenericState<LyricState>>
    with ConnectivityMixin {
  final IUseCases useCases;
  final ILyricsUseCases lyricUseCases;

  //final String path = 'lyrics/20';
  LyricBloc({
    required this.useCases,
    required this.lyricUseCases,
  }) : super(LoadingState<LyricState>()) {
    on<GetDataEvent<LyricEvent>>(_getInSupa);
    on<FilterEvent<LyricEvent>>(_filter);
    on<LoadingEvent<LyricEvent>>(_loading);
    on<CheckConnectivityEvent<LyricEvent>>(_checkConnectivity);
  }

  Future<void> _checkConnectivity(
      CheckConnectivityEvent<LyricEvent> event, emit) async {
    final response = await isConnected();
    if (response) {
      add(GetDataEvent<LyricEvent>());
    } else {
      emit(NoConnectionState<LyricState>());
    }
  }

  Future<void> _getInSupa(GetDataEvent<LyricEvent> event, emit) async {
    List<LyricEntity>? lyricsList =
        await MockUtil.convertMockJson<List<LyricModel>>(
      'assets/mocks/lyrics_mock.json',
      'lyrics',
    );
    if (lyricsList!.isNotEmpty) {
      emit(DataFetchedState<LyricState, List<LyricEntity>>(
          entities: lyricsList));
    }
  }

  /*Future<void> _getInSupa(GetInSupaEvent<LyricEvent> event, emit) async {
    await emit.onEach<List<LyricEntity>>(
      await supaUseCase.get(path),
      onData: (lyrics) {
        emit(DataFetchedState<LyricState, LyricEntity>(entities: lyrics));
      },
      onError: (error, st) {
        AnalyticsUtil.recordError(name: 'lyrics bloc', error: error, st: st);
        AnalyticsUtil.setCustomKey(name: 'lyrics bloc', key: 'get supa lyrics bloc', value: error.toString());
        emit(ExceptionState<LyricState>(message: error.toString()));
      },
    );
  }*/

  Future<void> _loading(_, emit) async {
    emit(LoadingState<LyricState>());
  }

  Future<void> _filter(FilterEvent<LyricEvent> event, emit) async {
    List<LyricEntity> lyricsList =
        await lyricUseCases.lettersFilter(event.lyrics);
    emit(DataFetchedState<LyricState, List<LyricEntity>>(entities: lyricsList));
  }
}

@immutable
abstract class LyricEvent {}

@immutable
abstract class LyricState {}

@immutable
abstract class FilterEvent<R> extends GenericEvent<R> {
  final List<LyricEntity> lyrics;
  FilterEvent({required this.lyrics});
}
