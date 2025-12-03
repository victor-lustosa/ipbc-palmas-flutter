import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:lyric_module/src/ui/blocs/type_filter.dart';

class LyricBloc extends Bloc<GenericEvent<LyricEvent>, GenericState<LyricState>>
    with ConnectivityMixin {
  LyricBloc({
    required LyricsListStore lyricsListStore,
    required GenericEventBus<GenericState<LyricsListState>> eventBus,
    required ManageLyricStore manageLyricStore,
  }) : _lyricsListStore = lyricsListStore,
       _manageLyricStore = manageLyricStore,
       _eventBus = eventBus,
       super(InitialState<LyricState>()) {
    on<GetDataEvent<LyricEvent>>(_getInSupa);
    on<AddDataEvent<LyricEvent>>(_addInSupa);
    on<FilterEvent<LyricEvent, LyricEntity>>(_filter);
    on<GetPaginationEvent<LyricEvent, LyricEntity>>(_getPaginationInSupa);
  }

  final GenericEventBus<GenericState<LyricsListState>> _eventBus;
  int viewHashCode = 0;
  bool isSelected = false;
  String selectedValue = '';
  final LyricsListStore _lyricsListStore;
  final ManageLyricStore _manageLyricStore;

  final TextEditingController _controller = TextEditingController();

  LyricsListStore get lyricsListStore => _lyricsListStore;

  ManageLyricStore get manageLyricStore => _manageLyricStore;

  TextEditingController get controller => _controller;

  final Map<String, Object> lyricParams = {
    'table': 'lyrics',
    'orderBy': 'create_at',
    'ascending': false,
    'selectFields': 'id, title, group, album_cover, create_at, verses',
  };

  Future<void> init({required BuildContext context}) async {
    add(GetDataEvent<LyricEvent>(context: context));
    _manageLyricStore.buttonCallback = () {
      add(GetDataEvent<LyricEvent>(context: context));
      pop(context);
    };
  }

  int selectedIndex = 0;

  int selectOptions(int index) {
    selectedIndex = index;
    return selectedIndex;
  }

  Future<void> _addInSupa(AddDataEvent<LyricEvent> event, emit) async {
    final response = await isConnected(context: event.context);
    if (response) {
      if (event.context.mounted) {
        showAddLyricsDialog(
          context: event.context,
          callback: (Map<String, String>? map) async {
            _manageLyricStore.hasAttached = false;
            _manageLyricStore.buttonCallback = () {
              _lyricsListStore.updateList(_manageLyricStore.lyric.value);
              _manageLyricStore.hasAttached = true;
              popUntil(
                    (route) =>
                route.settings.name == AppRoutes.initialRoute,
              );
              _eventBus.emit(DataFetchedState());
            };
            _manageLyricStore.attachLyric(context: event.context, map: map);
            pushNamed(AppRoutes.lyricsRoute + AppRoutes.manageLyricsSlideRoute);
          },
        );
      }
      if (emit.isDone) return;
      emit(DataFetchedState<LyricState>());
    } else {
      emit(NoConnectionState<LyricState>());
    }
  }

  Future<void> _getInSupa(GetDataEvent<LyricEvent> event, emit) async {
    final response = await isConnected(context: event.context);
    if (response) {
      if (event.context.mounted) {
        _eventBus.emit(LoadingState());
        List entities = await _manageLyricStore.getOnlineLyrics(
          context: event.context,
          params: lyricParams,
        );
        if (entities.isEmpty) {
          _eventBus.emit(NotFoundState());
        } else {
          _eventBus.emit(DataFetchedState(entities: entities));
        }
      }
      if (emit.isDone) return;
      emit(DataFetchedState<LyricState>());
    } else {
      _eventBus.emit(NoConnectionState());
    }
  }

  Future<void> _getPaginationInSupa(
    GetPaginationEvent<LyricEvent, LyricEntity> event,
    emit,
  ) async {
    List<LyricEntity> lyricsListAux = [];
    int offset = _lyricsListStore.entitiesList.length;
    lyricsListAux = await _manageLyricStore.getOnlineLyricsPagination(
      context: event.context,
      params: {'table': 'lyrics', 'limit': event.limit, 'offset': offset},
    );
    //Verificando se tem novos itens retornados se sim eu adiciona lista principal
    if (lyricsListAux.isNotEmpty) {
      _lyricsListStore.entitiesList.addAll(lyricsListAux);
      emit(DataFetchedState<LyricState>());
    } else {
      emit(NoMoreDataState<LyricState, List<LyricEntity>>());
    }
  }

  Future<void> _filter(FilterEvent<LyricEvent, LyricEntity> event, emit) async {
    if (event.writing) {
      _lyricsListStore.entitiesList = event.typeFilter.filterListing(
        event,
        _lyricsListStore.entitiesList,
      );
      emit(DataFetchedState<LyricState>());
    } else {
      emit(DataFetchedState<LyricState>());
    }
  }

  void editLyric(BuildContext context) {
    _manageLyricStore.isEditing = true;
    _manageLyricStore.lyric.value = lyricsListStore.selectedLyric;
    pushNamed(AppRoutes.lyricsRoute + AppRoutes.manageLyricsFadeRoute);
    Future.delayed(Duration(seconds: 1), () {
      _lyricsListStore.value = RefreshingState();
    });
    pop(context);
  }

  void deleteLyric({required BuildContext context}) async {
    String? lyricIdParam = lyricsListStore.selectedLyric.id;
    if (lyricIdParam != null) {
      _manageLyricStore.deleteLyric(context: context, lyricId: lyricIdParam);
      Future.delayed(Duration(seconds: 1), () {
        _lyricsListStore.value = RefreshingState();
      });
      popToast(1);
    }
  }
}

@immutable
abstract class LyricEvent {}

@immutable
abstract class LyricState {}

@immutable
class GetPaginationEvent<R, T> extends GenericEvent<R> {
  final int limit;
  final BuildContext context;

  GetPaginationEvent(this.limit, {required this.context});
}

@immutable
class NoMoreDataState<R, T> extends GenericEvent<R> {
  NoMoreDataState();
}

@immutable
class FilterEvent<R, T> extends GenericEvent<R> {
  final String searchText;
  final bool writing;
  final Filter<T, FilterEvent> typeFilter;
  final int selectIndex;

  FilterEvent(this.searchText, this.writing, this.typeFilter, this.selectIndex);
}

class TitleFilter extends Filter<LyricEntity, FilterEvent> {
  @override
  List<LyricEntity> filterListing(FilterEvent event, List<LyricEntity>? list) {
    List<LyricEntity> filterList;

    filterList = list!
        .where(
          (element) => element.title.toLowerCase().contains(event.searchText.toLowerCase()),
        )
        .toList();

    return filterList;
  }
}
//My artist filter

class ArtistFilter extends Filter<LyricEntity, FilterEvent> {
  @override
  List<LyricEntity> filterListing(FilterEvent event, List<LyricEntity>? list) {
    late List<LyricEntity> filterList;

    filterList = list!
        .where(
          (element) => element.group.toLowerCase().contains(event.searchText.toLowerCase()),
        )
        .toList();

    return filterList;
  }
}
