import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:ipbc_palmas/app/lyric/domain/use-cases/lyrics_use_cases.dart';

import '../../domain/entities/lyric_entity.dart';

class LyricBloc extends Bloc<LyricEvent, LyricState> {
  final ILyricsUseCases lyricsUseCase;

  LyricBloc({required this.lyricsUseCase}) : super(InitialState()) {
    on<GetLyricsEvent>(_getLyrics);
    on<LyricsFilterEvent>(_lyricsFilter);
  }

  Future<void> _getLyrics(GetLyricsEvent event, emit) async {
    await emit.onEach<List<LyricEntity>>(
      lyricsUseCase.get(event.url),
      onData: (lyrics) {
        emit(
          SuccessfullyFetchedLyricsState(lyrics),
        );
      },
      onError: (error, st) {
        emit(
          ExceptionLyricState(error.toString()),
        );
      },
    );
  }

  Future<void> _lyricsFilter(LyricsFilterEvent event, emit) async {
    List<LyricEntity> lyricsList = await lyricsUseCase.lettersFilter(
      event.lyrics,
      event.letter,
    );
    emit(
      SuccessfullyFilteredLyricsState(lyricsList),
    );
  }
}

@immutable
abstract class LyricEvent {}

class InitialEvent extends LyricEvent {
  InitialEvent();
}

class GetLyricsEvent extends LyricEvent {
  final String url;
  GetLyricsEvent({required this.url});
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

class ExceptionLyricState extends LyricState {
  final String message;

  ExceptionLyricState(this.message);
}

class SuccessfullyFetchedLyricsState extends LyricState {
  final List<LyricEntity> entities;
  SuccessfullyFetchedLyricsState(this.entities);
}

class SuccessfullyFilteredLyricsState extends LyricState {
  final List<LyricEntity> entities;
  SuccessfullyFilteredLyricsState(this.entities);
}
