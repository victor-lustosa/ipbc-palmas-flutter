import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:lyric_module/src/ui/blocs/type_filter.dart';

class LyricBloc extends Bloc<GenericEvent<LyricEvent>, GenericState<LyricState>>
    with ConnectivityMixin {
  final IUseCases onlineUseCases;
  final IUseCases? offlineUseCases;
  List<LyricModel>? lyricsList;
  final String path = 'lyrics/createAt/false/id, title, group, albumCover, createAt, lyrics_verses (verses(id, isChorus, versesList))';

  LyricBloc({
    required this.onlineUseCases,
    this.offlineUseCases,
  }) : super(LoadingState<LyricState>()) {
    on<GetDataEvent<LyricEvent>>(_getInSupa);
    on<FilterEvent<LyricEvent, LyricModel>>(_filter);
    on<LoadingEvent<LyricEvent>>(_loading);
    on<GetPaginationEvent<LyricEvent, LyricModel>>(_getPaginationInSupa);
    on<CheckConnectivityEvent<LyricEvent>>(_checkConnectivity);
  }

  Future<void> _checkConnectivity(
      CheckConnectivityEvent<LyricEvent> event, emit) async {
    final response = await isConnected();
    if (response) {
      add(GetDataEvent<LyricEvent>());
    } else {
      emit(NoConnectionState<LyricState>());
    }
  }

  Future<void> _getInSupa(GetDataEvent<LyricEvent> event, emit) async {
    //Caso esteja sem conexão eu salvo essas musicas no isar
    lyricsList = await onlineUseCases.get(
      path: path,
      converter: LyricAdapter.fromMapList,
    );
    if (lyricsList!.isNotEmpty) {
      emit(DataFetchedState<LyricState, List<LyricModel>>(
          entities: lyricsList!));
    }
  }

  Future<void> _getPaginationInSupa(
      GetPaginationEvent<LyricEvent, LyricModel> event, emit) async {
    List<LyricModel> lyricsListAux = [];
    //Caso esteja sem conexão eu salvo essas musicas no hive
    int offset = lyricsList!.length;

    String pathLimit = 'lyrics/${event.limit}/$offset';
    lyricsListAux = await onlineUseCases.get(
      path: pathLimit,
      converter: LyricAdapter.fromMapList,
    );
    //Verificando se tem novos itens retornados se sim eu adiciona lista principal
    if (lyricsListAux.isNotEmpty) {
      lyricsList!.addAll(lyricsListAux);
      emit(DataFetchedState<LyricState, List<LyricModel>>(entities: lyricsList!));
    } else {
      emit(NoMoreDataState<LyricState, List<LyricModel>>());
    }
  }

/*Future<void> _getInSupa(GetInSupaEvent<LyricEvent> event, emit) async {
    await emit.onEach<List<LyricEntity>>(
      await supaUseCase.get(path),
      onData: (lyrics) {
        emit(DataFetchedState<LyricState, LyricEntity>(entities: lyrics));
      },
      onError: (error, st) {
        AnalyticsUtil.recordError(name: 'lyrics bloc', error: error, st: st);
        AnalyticsUtil.setCustomKey(name: 'lyrics bloc', key: 'get supa lyrics bloc', value: error.toString());
        emit(ExceptionState<LyricState>(message: error.toString()));
      },
    );
  }*/

  Future<void> _loading(_, emit) async {
    emit(LoadingState<LyricState>());
  }

  Future<void> _filter(FilterEvent<LyricEvent, LyricModel> event, emit) async {
    if (event.writing && lyricsList != null) {
      List<LyricModel> list = event.typeFilter.filterListing(event, lyricsList);

      emit(DataFetchedState<LyricState, List<LyricModel>>(entities: list));
    } else {
      emit(DataFetchedState<LyricState, List<LyricModel>>(entities: lyricsList!));
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
          (element) => element.title
              .toLowerCase()
              .contains(event.searchText.toLowerCase()),
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
          (element) => element.group
              .toLowerCase()
              .contains(event.searchText.toLowerCase()),
        )
        .toList();

    return filterList;
  }
}
