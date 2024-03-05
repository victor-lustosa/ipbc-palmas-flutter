import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class LyricBloc extends Bloc<GenericEvent<LyricEvent>, GenericState<LyricState>> with ConnectivityMixin{
  final ILyricsUseCases supaUseCase;
  final String path = 'lyrics/20';

  LyricBloc({
    required this.supaUseCase,
  }) : super(LoadingState<LyricState>()) {
    on<GetInSupaEvent<LyricEvent>>(_getInSupa);
    on<FilterEvent<LyricEvent>>(_filter);
    on<LoadingEvent<LyricEvent>>(_loading);
    on<CheckConnectivityEvent<LyricEvent>>(_checkConnectivity);
  }

  Future<void> _checkConnectivity(
      CheckConnectivityEvent<LyricEvent> event, emit) async {
    final response = await isConnected();
    if (response) {
      add(GetInSupaEvent<LyricEvent>());
    } else {
      emit(NoConnectionState<LyricState>());
    }
  }

  Future<void> _getInSupa(GetInSupaEvent<LyricEvent> event, emit) async {
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
  }

  Future<void> _loading(_, emit) async {
    emit(LoadingState<LyricState>());
  }

  Future<void> _filter(FilterEvent<LyricEvent> event, emit) async {
    List<LyricEntity> lyricsList = await supaUseCase.lettersFilter(event.lyrics);
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
