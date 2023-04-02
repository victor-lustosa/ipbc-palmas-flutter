import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../domain/use-cases/lyrics_use_cases.dart';
import '../../domain/entities/lyric_entity.dart';

class LyricBloc extends Bloc<LyricEvent, LyricState> {
  final ILyricsUseCases fireLyricsUseCase;
  final ILyricsUseCases hiveLyricsUseCase;

  LyricBloc({required this.fireLyricsUseCase, required this.hiveLyricsUseCase})
      : super(InitialState()) {
    on<GetLyricsInFireEvent>(_getLyricsInFire);
    on<GetLyricsInHiveEvent>(_getLyricsInHive);
    on<AddLyricsInHiveEvent>(_addLyricsInHive);
    on<LyricsFilterEvent>(_lyricsFilter);
  }

  Future<void> _getLyricsInFire(GetLyricsInFireEvent event, emit) async {
    await emit.onEach<List<LyricEntity>>(
      await fireLyricsUseCase.get(event.path),
      onData: (lyrics) {
        for(LyricEntity entity in lyrics){
          add(AddLyricsInHiveEvent(path: 'lyrics', data: entity));
        }
        emit(SuccessfullyFetchedLyricsState(lyrics));
      },
      onError: (error, st) {
        emit(ExceptionLyricState(error.toString()));
      },
    );
  }

  Future<void> _getLyricsInHive(GetLyricsInHiveEvent event, emit) async {
    await emit.onEach<List<LyricEntity>>(
      await hiveLyricsUseCase.get(event.path),
      onData: (lyrics) {
        emit(SuccessfullyFetchedLyricsState(lyrics));
      },
      onError: (error, st) {
        emit(ExceptionLyricState(error.toString()));
      },
    );
  }

  Future<void> _addLyricsInHive(AddLyricsInHiveEvent event, emit) async {
    hiveLyricsUseCase.add(event.path, event.data);
  }

  Future<void> _lyricsFilter(LyricsFilterEvent event, emit) async {
    List<dynamic> lyricsList =
        await fireLyricsUseCase.lettersFilter(event.lyrics, event.letter);
    emit(SuccessfullyFilteredLyricsState(lyricsList as List<LyricEntity>));
  }
}

@immutable
abstract class LyricEvent {}

class InitialEvent extends LyricEvent {
  InitialEvent();
}

class GetLyricsInFireEvent extends LyricEvent {
  final String path;
  GetLyricsInFireEvent({required this.path});
}

class GetLyricsInHiveEvent extends LyricEvent {
  final String path;
  GetLyricsInHiveEvent({required this.path});
}

class AddLyricsInHiveEvent extends LyricEvent {
  final String path;
  final dynamic data;
  AddLyricsInHiveEvent({required this.path, required this.data});
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
