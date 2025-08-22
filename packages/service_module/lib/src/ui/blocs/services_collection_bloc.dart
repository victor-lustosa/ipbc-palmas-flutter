import 'dart:async';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class ServicesCollectionBloc
    extends
        Bloc<
          GenericEvent<ServicesCollectionEvent>,
          GenericState<ServicesCollectionState>
        >
    with ConnectivityMixin {
  final IUseCases onlineUseCases;
  final IUseCases? offlineUseCases;
  final EditLiturgyStore editStore;
  late Map<String, Object> servicesCollectionParams;
  List<ServiceEntity> entitiesList = [];
  ServicesCollectionBloc({required this.editStore, required this.onlineUseCases, this.offlineUseCases})
    : super(LoadingState()) {
    on<GetDataEvent<ServicesCollectionEvent>>(_getInSupa);
    on<LoadingEvent<ServicesCollectionEvent>>(_loading);
    on<DeleteItemEvent>(_deleteItem);
  }

  /*Future<void> _getInSupa(
      GetInSupaEvent<ServicesCollectionEvent> event, emit) async {
    List<ServiceEntity>? servicesCollectionList =
        await MockUtil.convertMockJson<List<ServiceEntity>>(
      'assets/mocks/${path[2]}_mock.json',
          path[2],
    );
    if (servicesCollectionList!.isNotEmpty) {
      emit(
        DataFetchedState<ServicesCollectionState, ServiceEntity>(
          entities: servicesCollectionList,
        ),
      );
    }
  }*/

  Future<void> _getInSupa(GetDataEvent event, emit) async {
    final response = await isConnected();
    if (response) {
      List<String> pathList = event.path.split('/');
      servicesCollectionParams = {
        'table': 'service',
        'orderBy': 'create_at',
        'filterColumn': pathList[1],
        'filterValue':  pathList[2],
        'ascending':  bool.parse(pathList[4]),
        'selectFields':
            'id, create_at, image, title, theme, preacher, service_date, heading, type, guide_is_visible, liturgies, service_lyrics (lyrics(id, title, group, albumCover, createAt, lyrics_verses (verses(id, isChorus, versesList))))',
      };
      add(LoadingEvent<ServicesCollectionEvent>());
      List<ServiceEntity> services = await onlineUseCases.get(
        params: servicesCollectionParams,
        converter: ServiceAdapter.fromMapList,
      );
      entitiesList = services;
      emit(
        DataFetchedState<ServicesCollectionState, List<ServiceEntity>>(),
      );
    } else {
      emit(NoConnectionState<ServicesCollectionState>());
    }
  }

  Future<void> _deleteItem(event, emit) async {
    final service = entitiesList[event.index];
    final response = await editStore.delete(service);
    if(response != null){
      entitiesList.remove(service);
    }
    emit(
      DataFetchedState<ServicesCollectionState, List<ServiceEntity>>(),
    );
  }

  void editItem({required int index, required ServicesEntity servicesEntity}) {
    editStore.edit(serviceEntityParam: entitiesList[index],servicesEntityParam: servicesEntity);
    pushNamed(
      AppRoutes.servicesRoute +
          AppRoutes.editLiturgiesRoute,
    );
  }

  void addItem({required ServicesEntity servicesEntity}) {
    editStore.servicesEntity = servicesEntity;
    pushNamed(AppRoutes.servicesRoute + AppRoutes.editLiturgiesRoute);
  }


  void _loading(_, emit) async {
    emit(LoadingState<ServicesCollectionState>());
  }
}

@immutable
abstract class ServicesCollectionEvent {}

class DeleteItemEvent extends GenericEvent<ServicesCollectionEvent> {
  DeleteItemEvent({required this.index});
  final int index;
}

@immutable
abstract class ServicesCollectionState {}

class UpdateServicesListState extends GenericState<ServicesCollectionState> {}