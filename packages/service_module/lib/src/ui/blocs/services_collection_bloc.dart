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
  }) : _serviceStore = serviceStore,
       super(LoadingState()) {
    on<GetDataEvent<ServicesCollectionEvent>>(_getInSupa);
    on<LoadingEvent<ServicesCollectionEvent>>(_loading);
    on<DeleteItemEvent>(_deleteItem);
  }

  final ServiceStore _serviceStore;

  ServiceStore get serviceStore => _serviceStore;

  void _updateServicesCollectionCallback(BuildContext context) {
    add(GetDataEvent(context: context));
  }

  void _updateCallBack() {
    _serviceStore.isChanged.value = true;
    popAndPushNamed(AppRoutes.servicesRoute + AppRoutes.serviceRoute);
  }

  Future<void> _getInSupa(dynamic event, emit) async {
    final response = await isConnected(context: event.context);
    if (response) {
      List<String> pathList = path.split('/');
      servicesCollectionParams = SchemaUtil.servicesCollectionParams(
        extra: {
          'filterColumn': pathList[1],
          'filterValue': pathList[2],
          'ascending': bool.parse(pathList[4]),
        },
      );
      add(LoadingEvent<ServicesCollectionEvent>());
      final response = await onlineUseCases.get(
        params: servicesCollectionParams,
      );
      response.fold(
        (l) => entitiesList = ServiceAdapter.fromMapList(l),
        (r) => null,
      );
      emit(DataFetchedState<ServicesCollectionState>());
    } else {
      emit(NoConnectionState<ServicesCollectionState>());
    }
  }

  Future<void> _deleteItem(dynamic event, emit) async {
    final service = entitiesList[event.index];
    final response = await manageServiceStore.delete(service, event.context);
    popToast(2);

    if (response != null) {
      entitiesList.remove(service);
    }

    showCustomToast(
      context: event.context,
      title: 'Sucesso!',
      message: 'Música deletada com sucesso.',
    );
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
    _serviceStore.updateServicesCollectionCallback =
        _updateServicesCollectionCallback;
    manageServiceStore.updateCallbackParam = _updateCallBack;
    pushNamed(AppRoutes.servicesRoute + AppRoutes.manageServicesRoute);
  }

  void _loading(_, dynamic emit) async {
    emit(LoadingState<ServicesCollectionState>());
  }

  void toService(
    ServicesEntity servicesEntityParam,
    ServiceEntity serviceEntityParam,
  ) {
    Modular.get<ServiceStore>().servicesEntity = servicesEntityParam;
    Modular.get<ServiceStore>().serviceEntity = serviceEntityParam;
    _serviceStore.entitiesList = [];
    if (serviceEntityParam.lyricsList != null &&
        serviceEntityParam.lyricsList!.isNotEmpty) {
      _serviceStore.entitiesList = serviceEntityParam.lyricsList!;
    }
    pushNamed(AppRoutes.servicesRoute + AppRoutes.serviceRoute);
  }
}

@immutable
abstract class ServicesCollectionEvent {}

class DeleteItemEvent extends GenericEvent<ServicesCollectionEvent> {
  DeleteItemEvent({required this.context, required this.index});

  final BuildContext context;
  final int index;
}

@immutable
abstract class ServicesCollectionState {}

class UpdateServicesListState extends GenericState<ServicesCollectionState> {}
