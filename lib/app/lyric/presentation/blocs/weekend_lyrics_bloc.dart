import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:ipbc_palmas/app/lyric/domain/use-cases/lyrics_use_cases.dart';

import '../../domain/entities/lyric_entity.dart';

class WeekendLyricsBloc extends Bloc<WeekendLyricsEvent, WeekendLyricsState> {
  final ILyricsUseCases lyricsUseCase;

  WeekendLyricsBloc({required this.lyricsUseCase}) : super(InitialState()) {
    on<GetWeekendLyricsEvent>(_getLyrics);
  }

  Future<void> _getLyrics(GetWeekendLyricsEvent event, emit) async {
    await emit.onEach<List<LyricEntity>>(
      lyricsUseCase.get(event.url),
      onData: (lyrics) {
        emit(
          SuccessfullyFetchedWeekendLyricsState(lyrics),
        );
      },
      onError: (error, st) {
        emit(
          ExceptionLyricState(error.toString()),
        );
      },
    );
  }
}

@immutable
abstract class WeekendLyricsEvent {}

class InitialEvent extends WeekendLyricsEvent {
  InitialEvent();
}

class GetWeekendLyricsEvent extends WeekendLyricsEvent {
  final String url;
  GetWeekendLyricsEvent({required this.url});
}

@immutable
abstract class WeekendLyricsState {}

class InitialState extends WeekendLyricsState {
  InitialState();
}

class ExceptionLyricState extends WeekendLyricsState {
  final String message;

  ExceptionLyricState(this.message);
}

class SuccessfullyFetchedWeekendLyricsState extends WeekendLyricsState {
  final List<LyricEntity> entities;
  SuccessfullyFetchedWeekendLyricsState(this.entities);
}
