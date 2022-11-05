part of 'lyric_bloc.dart';

@immutable
abstract class LyricEvent {}

class InitialEvent extends LyricEvent {
  InitialEvent();
}

class GetLyricsEvent extends LyricEvent {
  GetLyricsEvent();
}

class LyricsFilterEvent extends LyricEvent {
 final String letter;
 final List<LyricEntity> lyrics;
  LyricsFilterEvent({required this.letter,required this.lyrics});
}