import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:lyric_module/src/ui/blocs/type_filter.dart';

class LyricBloc extends Bloc<GenericEvent<LyricEvent>, GenericState<LyricState>>
    with ConnectivityMixin {

  LyricBloc({
    required this.onlineUseCases,
    this.offlineUseCases,
    required LyricsListStore lyricsListStore,
    required ManageLyricStore manageLyricStore,
  }) : _lyricsListStore = lyricsListStore,
       _manageLyricStore = manageLyricStore,
       super(LoadingState<LyricState>()) {
    on<GetDataEvent<LyricEvent>>(_getInSupa);
    on<FilterEvent<LyricEvent, LyricEntity>>(_filter);
    on<LoadingEvent<LyricEvent>>(_loading);
    on<GetPaginationEvent<LyricEvent, LyricEntity>>(_getPaginationInSupa);
  }

  final IUseCases onlineUseCases;
  final IUseCases? offlineUseCases;

  bool isSelected = false;

  String selectedValue = '';

  final TextEditingController _controller = TextEditingController();

  final LyricsListStore _lyricsListStore;
  final ManageLyricStore _manageLyricStore;

  LyricsListStore get lyricsListStore => _lyricsListStore;
  ManageLyricStore  get manageLyricStore => _manageLyricStore;
  get controller => _controller;

  final Map<String, Object> lyricParams = {
    'table': 'lyrics',
    'orderBy': 'create_at',
    'ascending': false,
    'selectFields':
        'id, title, group, album_cover, create_at, verses',
  };

  init({required BuildContext context}) async {
    add(GetDataEvent<LyricEvent>());
    _manageLyricStore.buttonCallback = () {
      add(GetDataEvent<LyricEvent>());
      pop(context);
    };
  }

  int selectedIndex = 0;

  int selectOptions(int index) {
    selectedIndex = index;
    return selectedIndex;
  }

  Future<void> _getInSupa(GetDataEvent<LyricEvent> event, emit) async {
    final response = await isConnected();
    if (response) {
      final lyricsList = await onlineUseCases.get(
        params: lyricParams,
        converter: LyricAdapter.fromMapList,
      );
      _lyricsListStore.entitiesList = lyricsList;
      emit(DataFetchedState<LyricState>());
    } else {
      emit(NoConnectionState<LyricState>());
    }
  }

  Future<void> _getPaginationInSupa(
    GetPaginationEvent<LyricEvent, LyricEntity> event,
    emit,
  ) async {
    List<LyricEntity> lyricsListAux = [];
    int offset = _lyricsListStore.entitiesList.length;
    final Map<String, Object> paginationParams = {
      'table': 'lyrics',
      'limit': event.limit,
      'offset': offset,
    };
    lyricsListAux = await onlineUseCases.get(
      params: paginationParams,
      converter: LyricAdapter.fromMapList,
    );
    //Verificando se tem novos itens retornados se sim eu adiciona lista principal
    if (lyricsListAux.isNotEmpty) {
      _lyricsListStore.entitiesList.addAll(lyricsListAux);
      emit(DataFetchedState<LyricState>());
    } else {
      emit(NoMoreDataState<LyricState, List<LyricEntity>>());
    }
  }

  Future<void> _loading(_, emit) async {
    emit(LoadingState<LyricState>());
  }

  Future<void> _filter(FilterEvent<LyricEvent, LyricEntity> event, emit) async {
    if (event.writing) {
      _lyricsListStore.entitiesList = event.typeFilter.filterListing(event, _lyricsListStore.entitiesList);
      emit(DataFetchedState<LyricState>());
    } else {
      emit(DataFetchedState<LyricState>());
    }
  }

  void editLyric(BuildContext context) {
    manageLyricStore.isEditing = true;
    manageLyricStore.lyric.value = lyricsListStore.lyricEntity;
    pushNamed(
      AppRoutes.servicesRoute + AppRoutes.manageLyricsRoute,
    );
    Future.delayed(Duration(seconds: 1), () {
      _lyricsListStore.value = UpdateTilesState();
    });
    pop(context);
  }

  void deleteLyric({required BuildContext context}) async{
    String? lyricIdParam = lyricsListStore.lyricEntity.id;
    if (lyricIdParam != null) {
      manageLyricStore.deleteLyric(
        context: context,
        lyricId: lyricIdParam,
      );
      Future.delayed(Duration(seconds: 1), () {
        _lyricsListStore.value = UpdateTilesState();
      });
      pop(context);
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

  GetPaginationEvent(this.limit);
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
          (element) => element.title.toLowerCase().contains(
            event.searchText.toLowerCase(),
          ),
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
          (element) => element.group.toLowerCase().contains(
            event.searchText.toLowerCase(),
          ),
        )
        .toList();

    return filterList;
  }
}
