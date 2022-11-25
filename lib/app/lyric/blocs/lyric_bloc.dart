import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:ipbc_palmas/app/lyric/domain/use-cases/lyrics_use_cases.dart';

import '../domain/entities/lyric_entity.dart';

part 'lyric_event.dart';

part 'lyric_state.dart';

class LyricBloc extends Bloc<LyricEvent, LyricState> {
  final ILyricsUseCases lyricsUseCase;

  LyricBloc({required this.lyricsUseCase}) : super(InitialState()) {
    on<GetLyricsEvent>(_getLyrics);
    on<LyricsFilterEvent>(_lyricsFilter);
  }

  Future<void> _getLyrics(_, emit) async {
    await emit.onEach<List<LyricEntity>>(
      lyricsUseCase.get(),
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
