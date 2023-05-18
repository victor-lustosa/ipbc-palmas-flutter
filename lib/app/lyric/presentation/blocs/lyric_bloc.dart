import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../view-models/lyrics_view_model.dart';
import '../../domain/entities/lyric_entity.dart';
import '../../domain/use-cases/lyrics_use_cases.dart';
import '../../../shared/components/utils/analytics_util.dart';

class LyricBloc extends Bloc<LyricEvent, LyricState> {
  final ILyricsUseCases fireLyricsUseCase;
  final ILyricsUseCases hiveLyricsUseCase;
  final LyricsViewModel lyricsViewModel;
  final AnalyticsUtil analyticsUtil;
  final String path = 'lyrics/20';

  LyricBloc(
      {required this.lyricsViewModel,
      required this.analyticsUtil,
      required this.fireLyricsUseCase,
      required this.hiveLyricsUseCase})
      : super(InitialState()) {
    on<GetLyricsInFireEvent>(_getLyricsInFire);
    on<GetLyricsInHiveEvent>(_getLyricsInHive);
    on<UpdateLyricsInHiveEvent>(_updateLyricsInHive);
    on<LyricsFilterEvent>(_lyricsFilter);
    on<LoadingEvent>(_loading);
    on<CheckConnectivityEvent>(_checkConnectivity);
  }

  Future<void> _checkConnectivity(CheckConnectivityEvent event, emit) async {
    final isConnected = await lyricsViewModel.isConnected();
    if (isConnected) {
      add(GetLyricsInFireEvent());
    } else {
      emit(NoConnectionAvailableState());
    }
  }

  Future<void> _getLyricsInFire(GetLyricsInFireEvent event, emit) async {
    await emit.onEach<List<LyricEntity>>(
      await fireLyricsUseCase.get(path),
      onData: (lyrics) {
        emit(LyricsSuccessfullyFetchedState(lyrics));
      },
      onError: (error, st) {
        emit(ExceptionLyricState(error.toString()));
        analyticsUtil.recordError(name:'lyric bloc', error: error,st: st);
        analyticsUtil.setCustomKey(name: 'lyric bloc', key: 'get fire lyrics bloc', value:  error.toString());
      },
    );
  }

  Future<void> _getLyricsInHive(GetLyricsInHiveEvent event, emit) async {
    await emit.onEach<List<LyricEntity>>(
      await hiveLyricsUseCase.get(path),
      onData: (lyrics) {
        emit(LyricsSuccessfullyFetchedState(lyrics));
      },
      onError: (error, st) async {
        analyticsUtil.recordError(name:'lyric bloc', error:error,st: st);
        analyticsUtil.setCustomKey(name: 'lyric bloc', key: 'get hive lyrics bloc', value:  error.toString());
        emit(ExceptionLyricState(error.toString()));
      },
    );
  }

  Future<void> _updateLyricsInHive(UpdateLyricsInHiveEvent event, emit) async {
    hiveLyricsUseCase.update(path, event.entities);
  }

  Future<void> _loading(_, emit) async {
    emit(LoadingLyricsState());
  }

  Future<void> _lyricsFilter(LyricsFilterEvent event, emit) async {
    List<dynamic> lyricsList = await fireLyricsUseCase.lettersFilter(event.lyrics, event.letter);
    emit(LyricsSuccessfullyFetchedState(lyricsList as List<LyricEntity>));
  }
}

@immutable
abstract class LyricEvent {}

class InitialEvent extends LyricEvent {
  InitialEvent();
}

class LoadingEvent extends LyricEvent {
  LoadingEvent();
}

class GetLyricsInFireEvent extends LyricEvent {
  GetLyricsInFireEvent();
}

class CheckConnectivityEvent extends LyricEvent {
  CheckConnectivityEvent();
}

class GetLyricsInHiveEvent extends LyricEvent {
  GetLyricsInHiveEvent();
}

class UpdateLyricsInHiveEvent extends LyricEvent {
  final dynamic entities;
  UpdateLyricsInHiveEvent({required this.entities});
}

class LyricsFilterEvent extends LyricEvent {
  final String letter;
  final List<LyricEntity> lyrics;
  LyricsFilterEvent({required this.letter, required this.lyrics});
}

@immutable
abstract class LyricState {}

class InitialState extends LyricState {
  InitialState();
}

class LoadingLyricsState extends LyricState {
  LoadingLyricsState();
}

class ExceptionLyricState extends LyricState {
  final String message;
  ExceptionLyricState(this.message);
}

class NoConnectionAvailableState extends LyricState {
  NoConnectionAvailableState();
}

class LyricsSuccessfullyFetchedState extends LyricState {
  final List<LyricEntity> entities;
  LyricsSuccessfullyFetchedState(this.entities);
}
