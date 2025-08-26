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
    on<FilterEvent<LyricEvent, LyricModel>>(_filter);
    on<LoadingEvent<LyricEvent>>(_loading);
    on<GetPaginationEvent<LyricEvent, LyricModel>>(_getPaginationInSupa);
  }

  final IUseCases onlineUseCases;
  final IUseCases? offlineUseCases;
  List<LyricModel> entitiesList = [];

  bool isSelected = false;

  String selectedValue = '';

  final TextEditingController _controller = TextEditingController();

  final LyricsListStore _lyricsListStore;
  final ManageLyricStore _manageLyricStore;

  get lyricsListStore => _lyricsListStore;
  get manageLyricStore => _manageLyricStore;
  get controller => _controller;

  final Map<String, Object> lyricParams = {
    'table': 'lyrics',
    'orderBy': 'create_at',
    'ascending': false,
    'selectFields':
        'id, title, group, album_cover, create_at, lyrics_verses (verses(id, is_chorus, verses_list))',
  };

  init({required BuildContext context}) async {
    add(GetDataEvent<LyricEvent>());
    _manageLyricStore.isEditing = true;
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
    //Caso esteja sem conexão eu salvo essas musicas no isar
    final response = await isConnected();
    if (response) {
      final lyricsList = await onlineUseCases.get(
        params: lyricParams,
        converter: LyricAdapter.fromMapList,
      );
      if (lyricsList!.isNotEmpty) {
        entitiesList = lyricsList;
        emit(DataFetchedState<LyricState>());
      }
    } else {
      emit(NoConnectionState<LyricState>());
    }
  }

  Future<void> _getPaginationInSupa(
    GetPaginationEvent<LyricEvent, LyricModel> event,
    emit,
  ) async {
    List<LyricModel> lyricsListAux = [];
    //Caso esteja sem conexão eu salvo essas musicas no hive
    int offset = entitiesList.length;

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
      entitiesList.addAll(lyricsListAux);
      emit(DataFetchedState<LyricState>());
    } else {
      emit(NoMoreDataState<LyricState, List<LyricModel>>());
    }
  }

  Future<void> _loading(_, emit) async {
    emit(LoadingState<LyricState>());
  }

  Future<void> _filter(FilterEvent<LyricEvent, LyricModel> event, emit) async {
    if (event.writing) {
      entitiesList = event.typeFilter.filterListing(event, entitiesList);
      emit(DataFetchedState<LyricState>());
    } else {
      emit(DataFetchedState<LyricState>());
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

class TitleFilter extends Filter<LyricModel, FilterEvent> {
  @override
  List<LyricModel> filterListing(FilterEvent event, List<LyricModel>? list) {
    List<LyricModel> filterList;

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

class ArtistFilter extends Filter<LyricModel, FilterEvent> {
  @override
  List<LyricModel> filterListing(FilterEvent event, List<LyricModel>? list) {
    late List<LyricModel> filterList;

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
