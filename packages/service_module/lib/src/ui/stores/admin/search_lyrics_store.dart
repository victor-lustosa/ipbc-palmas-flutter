import 'package:flutter/cupertino.dart';
import 'package:core_module/core_module.dart';

class SearchLyricsStore extends ValueNotifier<GenericState<SearchLyricsState>>{
  SearchLyricsStore() : super(InitialState());

  searchLyrics(String query) async {
    value = SearchingState();
    try {
      await Future.delayed(const Duration(seconds: 1));
      if (query.isEmpty) {
        value = NotFoundState();
      } else {
        value = SearchSuccessState();
      }
    } catch (e) {
      value = SearchErrorState();
    }
  }
}

@immutable
abstract class SearchLyricsState {}

class SearchingState extends GenericState<SearchLyricsState> {}

class SearchSuccessState extends GenericState<SearchLyricsState> {}

class SearchErrorState extends GenericState<SearchLyricsState> {}

class NotFoundState extends GenericState<SearchLyricsState> {}

