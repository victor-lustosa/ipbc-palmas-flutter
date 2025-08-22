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
  final ManageServiceStore editStore;
  Map<String, Object> servicesCollectionParams = {};
  List<ServiceEntity> entitiesList = [];
  late final Function updateCallback;
  late String path;

  ServicesCollectionBloc({
    required this.editStore,
    required this.onlineUseCases,
    this.offlineUseCases,
  }) : super(LoadingState()) {
    updateCallback = () {
      add(GetDataEvent());
    };

    on<GetDataEvent<ServicesCollectionEvent>>(_getInSupa);
    on<LoadingEvent<ServicesCollectionEvent>>(_loading);
    on<DeleteItemEvent>(_deleteItem);
  }

  Future<void> _getInSupa(_, emit) async {
    final response = await isConnected();
    if (response) {
      List<String> pathList = path.split('/');
      servicesCollectionParams = {
        'table': 'service',
        'orderBy': 'create_at',
        'filterColumn': pathList[1],
        'filterValue': pathList[2],
        'ascending': bool.parse(pathList[4]),
        'selectFields':
            'id, create_at, image, title, theme, preacher, service_date, heading, type, guide_is_visible, liturgies, service_lyrics (lyrics(id, title, group, albumCover, createAt, lyrics_verses (verses(id, isChorus, versesList))))',
      };
      add(LoadingEvent<ServicesCollectionEvent>());
      List<ServiceEntity> services = await onlineUseCases.get(
        params: servicesCollectionParams,
        converter: ServiceAdapter.fromMapList,
      );
      entitiesList = services;
      emit(DataFetchedState<ServicesCollectionState>());
    } else {
      emit(NoConnectionState<ServicesCollectionState>());
    }
  }

  Future<void> _deleteItem(event, emit) async {
    final service = entitiesList[event.index];
    final response = await editStore.delete(service);
    if (response != null) {
      entitiesList.remove(service);
    }
    emit(DataFetchedState<ServicesCollectionState>());
  }

  void editItem({required int index, required ServicesEntity servicesEntity}) {
    editStore.edit(
      serviceEntityParam: entitiesList[index],
      servicesEntityParam: servicesEntity,
    );
    editStore.updateCallbackParam = updateCallback;
    pushNamed(AppRoutes.servicesRoute + AppRoutes.manageServicesRoute);
  }

  Future<void> addItem({required ServicesEntity servicesEntity}) async {
    editStore.servicesEntity = servicesEntity;
    editStore.isEditing = false;
    editStore.updateCallbackParam = updateCallback;
    pushNamed(AppRoutes.servicesRoute + AppRoutes.manageServicesRoute);
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
