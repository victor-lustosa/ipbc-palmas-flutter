part of '../blocs/lyric_bloc.dart';

abstract class LyricState {}

class InitialState extends LyricState {
  InitialState();
}

class SuccessLyricsState extends LyricState {
  final List<LyricEntity> entities;
  SuccessLyricsState(this.entities);
}
