import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

import '../../shared/blocs/generics.dart';
import '../../shared/view-models/services_view_model.dart';

class LyricBloc extends Bloc<GenericEvent<LyricEvent>, GenericState<LyricState>> {
  final ILyricsUseCases supaUseCase;
  final ServicesViewModel viewModel;
  final AnalyticsUtil analyticsUtil;
  final String path = 'lyrics/20';

  LyricBloc({
    required this.viewModel,
    required this.analyticsUtil,
    required this.supaUseCase,
  }) : super(LoadingState<LyricState>()) {
    on<GetInSupaEvent<LyricEvent>>(_getInSupa);
    on<FilterEvent<LyricEvent>>(_filter);
    on<LoadingEvent<LyricEvent>>(_loading);
    on<CheckConnectivityEvent<LyricEvent>>(_checkConnectivity);
  }

  Future<void> _checkConnectivity(
      CheckConnectivityEvent<LyricEvent> event, emit) async {
    final isConnected = await viewModel.isConnected();
    if (isConnected) {
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
        analyticsUtil.recordError(name: 'lyric bloc', error: error, st: st);
        analyticsUtil.setCustomKey(name: 'lyric bloc', key: 'get supa lyrics bloc', value: error.toString());
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
