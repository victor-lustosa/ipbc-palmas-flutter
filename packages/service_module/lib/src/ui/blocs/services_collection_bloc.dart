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
  final ManageServiceStore manageServiceStore;
  Map<String, Object> servicesCollectionParams = {};
  List<ServiceEntity> entitiesList = [];
  late String path;

  ServicesCollectionBloc({
    required this.manageServiceStore,
    required this.onlineUseCases,
    required ServiceStore serviceStore,
    required LyricsListStore lyricsListStore,
  }) : _serviceStore = serviceStore,_lyricsListStore = lyricsListStore,
       super(LoadingState()) {
    on<GetDataEvent<ServicesCollectionEvent>>(_getInSupa);
    on<LoadingEvent<ServicesCollectionEvent>>(_loading);
    on<DeleteItemEvent>(_deleteItem);
  }
  final LyricsListStore _lyricsListStore;
  final ServiceStore _serviceStore;

  ServiceStore get serviceStore => _serviceStore;

  _updateServicesCollectionCallback() {
    add(GetDataEvent());
  }

  _updateCallBack() {
    _serviceStore.isChanged.value = true;
    popAndPushNamed(AppRoutes.servicesRoute + AppRoutes.serviceRoute);
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
            'id, create_at, image, title, theme, preacher, service_date, heading, type, guide_is_visible, liturgies, service_lyrics (lyrics(id, title, group, album_cover, create_at, verses)))',
      };
      add(LoadingEvent<ServicesCollectionEvent>());
      entitiesList = await onlineUseCases.get(
        params: servicesCollectionParams,
        converter: ServiceAdapter.fromMapList,
      );
      emit(DataFetchedState<ServicesCollectionState>());
    } else {
      emit(NoConnectionState<ServicesCollectionState>());
    }
  }

  Future<void> _deleteItem(event, emit) async {
    final service = entitiesList[event.index];
    final response = await manageServiceStore.delete(service);
    if (response != null) {
      entitiesList.remove(service);
    }
    emit(DataFetchedState<ServicesCollectionState>());
  }

  void editItem({required int index}) {
    manageServiceStore.serviceEntity = entitiesList[index];
    _serviceStore.updateServicesCollectionCallback =
        _updateServicesCollectionCallback;
    manageServiceStore.updateCallbackParam = _updateCallBack;
    manageServiceStore.edit();
    pushNamed(AppRoutes.servicesRoute + AppRoutes.manageServicesRoute);
  }

  Future<void> addItem() async {
    manageServiceStore.isEditing = false;
    _serviceStore.updateServicesCollectionCallback = _updateServicesCollectionCallback;
    manageServiceStore.updateCallbackParam = _updateCallBack;
    pushNamed(AppRoutes.servicesRoute + AppRoutes.manageServicesRoute);
  }

  void _loading(_, emit) async {
    emit(LoadingState<ServicesCollectionState>());
  }

  void toService(
    ServicesEntity servicesEntityParam,
    ServiceEntity serviceEntityParam,
  ) {
    Modular.get<ServiceStore>().servicesEntity = servicesEntityParam;
    Modular.get<ServiceStore>().serviceEntity = serviceEntityParam;
    _lyricsListStore.entitiesList = [];
    if (serviceEntityParam.lyricsList != null && serviceEntityParam.lyricsList!.isNotEmpty) {
      _lyricsListStore.entitiesList = serviceEntityParam.lyricsList!;
    }
    pushNamed(AppRoutes.servicesRoute + AppRoutes.serviceRoute);
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
