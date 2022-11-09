part of 'lyric_bloc.dart';

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
