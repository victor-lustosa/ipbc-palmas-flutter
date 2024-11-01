
import 'package:flutter/material.dart';

import '../../../home_module.dart';

class DatabaseBloc extends Bloc<GenericEvent<DatabasesEvent>, GenericState<DatabasesState>> {
  final IOfflineAuthUseCases useCases;
  final String path = 'auth';

  DatabaseBloc({required this.useCases})
      : super(LoadingState()) {
    on<GetInHiveEvent<DatabasesEvent>>(_getData);
  }

  _getData(GetInHiveEvent<DatabasesEvent> event, emit) async {
    //var data = await useCases.get(path);
   // if((data as HiveAuthDTO).token != ""){
      emit(FetchingDataState<DatabasesState>(false));
  //  } else {
   //   emit(FetchingDataState(true));
   // }
  }
}

@immutable
abstract class DatabasesEvent {}

@immutable
abstract class DatabasesState {}


class FetchingDataState<R> extends GenericState<R> {
  final bool isData;
  FetchingDataState(this.isData);
}

