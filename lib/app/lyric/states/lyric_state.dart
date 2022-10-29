part of '../blocs/lyric_bloc.dart';

abstract class LyricState {}

class InitialState extends LyricState {
  InitialState();
}

class SuccessfullyFetchedLyricsState extends LyricState {
  final List<LyricEntity> entities;
  SuccessfullyFetchedLyricsState(this.entities);
}
