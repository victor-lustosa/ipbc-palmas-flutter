part of '../blocs/lyric_bloc.dart';

@immutable
abstract class LyricEvent {}

class InitialEvent extends LyricEvent {
  InitialEvent();
}

class GetLyricsEvent extends LyricEvent {
  GetLyricsEvent();
}
