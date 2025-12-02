import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class LyricsListStore extends ValueNotifier<GenericState<LyricsListState>> {
  final GenericEventBus<GenericState<SearchState>> _eventBus;
  late final StreamSubscription _subscription;
  final ValueNotifier<int?> tappedIndex = ValueNotifier(null);
  List<LyricEntity> entitiesList = [];
  late GlobalKey itemKey;
  int index = 0;
  late LyricEntity selectedLyric;
  bool hasFixedData = false;

  LyricsListStore({
    required GenericEventBus<GenericState<SearchState>> eventBus,
  }) : _eventBus = eventBus,
       super(InitialState()) {
    _subscription = _eventBus.stream.listen((state) {
      if (hasFixedData) {
        return;
      }

      if (state is LoadingState) {
        tappedIndex.value = null;
        value = LoadingState();
      }

      if (state is NotFoundState) {
        value = NotFoundState();
      }

      if (state is DataFetchedState<SearchState>) {
        if (state.entities != null && state.entities!.isNotEmpty) {
          entitiesList = state.entities! as List<LyricEntity>;
        }
        value = DataFetchedState<LyricsListState>();
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    tappedIndex.dispose();
    super.dispose();
  }
}

@immutable
abstract class LyricsListState {}
