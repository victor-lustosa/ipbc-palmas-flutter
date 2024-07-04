import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

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
    on<FilterEvent<LyricEvent>>(_filter);
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

  Future<void> _filter(FilterEvent event, emit) async {
    if (event.writing) {
      /* onError -- bloc: LyricBloc, error: type 'DataFetchedState<dynamic, dynamic>'
       is not a subtype of type 'GenericState<LyricState>' of 'value' */
      
      emit(
        DataFetchedState<LyricState, LyricEntity>().copyWith(
          entities: lyricsList!
              .where(
                (element) => element.title.contains(event.searchText),
              )
              .toList(),
        ),
      );
    }

    // //Se o estado no ui for dataFilterState
    // if (state is DataFilteredState<LyricState>) {
    //   //Criasse um novo estado
    //   final newState = state as DataFilteredState;
    //   //A partir desse novo estado verifico se ele é o estado inicial(Não digitou nada ainda)
    //   if (newState.status == SearchState.initial) {
    //     // emit(new.);
    //   }
    //   //Caso a pessoa tenha digitado algo eu entro nesse estado de pesquisa no app
    //   else if (newState.status == SearchState.writing) {
    //     switch (event.typeFilter) {
    //       case 0:
    //         print('Implementar filtro de teste');
    //         //Quando ele começar a digitar eu chamo o checkConnection de novo, só que eu tenho que mudar o estado da lista alterando
    //         //a listagem conforme o texto passado
    //         break;
    //       case 1:
    //         print('Implementar filtro por trecho');
    //         break;
    //       case 2:
    //         print('Implementar filtro por autor');
    //         break;
    //     }
    //   }
  }

  // emit(DataFetchedState<LyricState, LyricEntity>(entities: lyricsList));
}

@immutable
abstract class LyricEvent {}

@immutable
abstract class LyricState {}

@immutable
class FilterEvent<R> extends GenericEvent<R> {
  final String searchText;
  final bool writing;

  FilterEvent(this.searchText, this.writing);
}
