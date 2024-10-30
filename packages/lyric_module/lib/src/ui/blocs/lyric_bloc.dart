import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:lyric_module/src/ui/blocs/type_filter.dart';

import '../../../lyric_module.dart';

class LyricBloc extends Bloc<GenericEvent<LyricEvent>, GenericState<LyricState>>
    with ConnectivityMixin {
  final ILyricsUseCases supaUseCase;
  List<LyricEntity>? lyricsList;
  final String path = 'lyrics/20';

  LyricBloc({
    required this.supaUseCase,
  }) : super(LoadingState<LyricState>()) {
    on<GetInSupaEvent<LyricEvent>>(_getInSupa);
    on<FilterEvent<LyricEvent, LyricEntity>>(_filter);
    on<LoadingEvent<LyricEvent>>(_loading);
    on<CheckConnectivityEvent<LyricEvent>>(_checkConnectivity);
  }

  Future<void> _checkConnectivity(
      CheckConnectivityEvent<LyricEvent> event, emit) async {
    final response = await isConnected();
    if (response) {
      add(GetInSupaEvent<LyricEvent>());
    } else {
      emit(NoConnectionState<LyricState>());
    }
  }

  Future<void> _getInSupa(GetInSupaEvent<LyricEvent> event, emit) async {
    //Caso esteja sem conexão eu salvo essas musicas no hive
    lyricsList = await supaUseCase.get(path);
    if (lyricsList!.isNotEmpty) {
      emit(DataFetchedState<LyricState, LyricEntity>(entities: lyricsList!));
    }
  }

  Future<void> _loading(_, emit) async {
    emit(LoadingState<LyricState>());
  }

  Future<void> _filter(FilterEvent<LyricEvent, LyricEntity> event, emit) async {
    if (event.writing && lyricsList != null) {
      List<LyricEntity> list =
          event.typeFilter.filterListing(event, lyricsList);

      emit(DataFetchedState<LyricState, LyricEntity>(entities: list));
    } else {
      emit(DataFetchedState<LyricState, LyricEntity>(entities: lyricsList!));
    }
  }
}

@immutable
abstract class LyricEvent {}

@immutable
abstract class LyricState {}

@immutable
class FilterEvent<R, T> extends GenericEvent<R> {
  final String searchText;
  final bool writing;
  final Filter<T, FilterEvent> typeFilter;
  final int selectIndex;

  FilterEvent(this.searchText, this.writing, this.typeFilter, this.selectIndex);
}

class MusicFilter extends Filter<LyricEntity, FilterEvent> {
  @override
  List<LyricEntity> filterListing(FilterEvent event, List<LyricEntity>? list) {
    List<LyricEntity> filterList;

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

class ArtistFilter extends Filter<LyricEntity, FilterEvent> {
  @override
  List<LyricEntity> filterListing(FilterEvent event, List<LyricEntity>? list) {
    late List<LyricEntity> filterList;

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
