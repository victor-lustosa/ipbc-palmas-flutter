import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:lyric_module/src/ui/view_models/type_filter.dart';

import '../../../lyric_module.dart';

class LyricBloc extends Bloc<GenericEvent<LyricEvent>, GenericState<LyricState>>
    with ConnectivityMixin {
  final ILyricsUseCases supaUseCase;
  List<LyricEntity>? lyricsList;
  //final String path = 'lyrics/20';
  LyricBloc({
    required this.supaUseCase,
  }) : super(LoadingState<LyricState>()) {
    on<GetInSupaEvent<LyricEvent>>(_getInSupa);
    on<FilterEvent<LyricEvent>>(_filterExcerpt);
    // on<FilterEvent<LyricEvent>>(_filterGroup);
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
    lyricsList = await MockUtil.convertMockJson<List<LyricModel>>(
      'assets/mocks/lyrics_mock.json',
      'lyrics',
    );
    if (lyricsList!.isNotEmpty) {
      emit(DataFetchedState<LyricState, LyricEntity>(entities: lyricsList!));
      // emit(DataFilteredState<LyricState>);
    }
  }

  Future<void> _loading(_, emit) async {
    emit(LoadingState<LyricState>());
  }

  Future<void> _filterExcerpt(FilterEvent event, emit) async {
    MyFilter(
            emit: emit(
              DataFetchedState<LyricState, LyricEntity>(
                  entities: lyricsList!
                      .where(
                        (element) => element.title
                            .toLowerCase()
                            .contains(event.searchText.toLowerCase()),
                      )
                      .toList()),
            ),
            addEvent: (GenericEvent addEvent) =>
                add(GetInSupaEvent<LyricEvent>()))
        .searchTypeFilter(event, lyricsList);
  }

  Future<void> _filterGroup(FilterEvent event, emit) async {
    MyFilter(
            emit: emit(
              DataFetchedState<LyricState, LyricEntity>(
                  entities: lyricsList!
                      .where(
                        (element) => element.group
                            .toLowerCase()
                            .contains(event.searchText.toLowerCase()),
                      )
                      .toList()),
            ),
            addEvent: (GenericEvent addEvent) =>
                add(GetInSupaEvent<LyricEvent>()))
        .searchTypeFilter(event, lyricsList);
  }
}

@immutable
abstract class LyricEvent {}

@immutable
abstract class LyricState {}
