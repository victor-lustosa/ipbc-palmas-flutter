import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:ipbc_palmas/app/lyric/domain/use-cases/lyrics_use_cases.dart';

import '../domain/entities/lyric_entity.dart';

part '../events/lyric_event.dart';
part '../states/lyric_state.dart';

class LyricBloc extends Bloc<LyricEvent, LyricState> {
  final ILyricsUseCases lyricsUseCase;

  LyricBloc({required this.lyricsUseCase}) : super(InitialState()) {
    on<GetLyricsEvent>(_getLyrics);
  }
  Future<void> _getLyrics(_, emit) async {
    await emit.onEach<List<LyricEntity>>(lyricsUseCase.get(), onData: (rooms) {
      emit(SuccessfullyFetchedLyricsState(rooms));
    });
  }
}
