import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class SearchLyricsStore extends ValueNotifier<GenericState<SearchLyricsState>> {
  SearchLyricsStore({
    required LyricsListStore lyricsListStore,
    required SearchStore searchStore,
    required ManageLyricStore manageLyricStore,
    required GenericEventBus<GenericState<LyricsListState>> eventBus,
  }) : _lyricsListStore = lyricsListStore,
       _searchStore = searchStore,
       _eventBus = eventBus,
        _manageLyricStore = manageLyricStore,
      super(InitialState()) {
    _subscription = _eventBus.stream.listen((state) {
      if (state.id != viewHashCode) {
        return;
      }
      if (state is LoadingState) {}

      if (state is NotFoundState) {}

      if (state is DataFetchedState<LyricsListState>) {}
    });
  }
  final LyricsListStore _lyricsListStore;
  final SearchStore _searchStore;
  final ManageLyricStore _manageLyricStore;
  final GenericEventBus<GenericState<LyricsListState>> _eventBus;
  late final StreamSubscription _subscription;
  final TextEditingController searchController = TextEditingController();
  int viewHashCode = 0;

  LyricsListStore get lyricsListStore => _lyricsListStore;

  ValueNotifier<bool> isAddEventPressed = ValueNotifier(false);

  void init(int hashCode) {
    _searchStore.limit = 6;
    viewHashCode = hashCode;
  }

  void resetList() {
    _eventBus.emit(RefreshingState());
  }

  @override
  dispose() {
    _subscription.cancel();
    _searchStore.limit = 0;
    super.dispose();
  }

  void attachLyric({Map<String, String>? map, required BuildContext context, String? serviceId}) {
    _manageLyricStore.serviceId = serviceId ?? '';
    _manageLyricStore.attachLyric(context: context, map: map);
    if(map != null) pop(context);
    pushNamed(AppRoutes.lyricsRoute + AppRoutes.manageLyricsFadeRoute);
  }
}

@immutable
abstract class SearchLyricsState {}
