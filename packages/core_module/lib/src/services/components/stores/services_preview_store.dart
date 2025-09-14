import 'package:flutter/cupertino.dart';
import 'package:core_module/core_module.dart';

class ServicesPreviewStore
    extends ValueNotifier<GenericState<ServicesPreviewState>> {
  ServicesPreviewStore({
    required ManageLyricStore manageLyricStore,
    required LyricsListStore lyricsListStore,
    required ManageServiceStore manageServiceStore,
  }) : _manageLyricStore = manageLyricStore,
       _lyricsListStore = lyricsListStore,
        _manageServiceStore = manageServiceStore,
       super(InitialState());

  final ManageLyricStore _manageLyricStore;
  final LyricsListStore _lyricsListStore;
  final ManageServiceStore _manageServiceStore;
  Function? updateServicesCollectionCallback;
  ValueNotifier<bool> isChanged = ValueNotifier(false);

  late ServiceEntity serviceEntity;
  late ServicesEntity servicesEntity;

  ValueNotifier<bool> isAdmin = ValueNotifier(true);

  ManageLyricStore get manageLyricStore => _manageLyricStore;
  LyricsListStore get lyricsListStore => _lyricsListStore;
  ManageServiceStore get manageServiceStore => _manageServiceStore;

  void edit() {
    _manageServiceStore.serviceEntity = serviceEntity;
    _manageServiceStore.servicesEntity = servicesEntity;
    _manageServiceStore.updateCallbackParam = () {
      serviceEntity = _manageServiceStore.serviceEntity!;
      isChanged.value = true;
      value = LoadingState();
      pop();
    };
    _manageServiceStore.edit();
    pushNamed(
      AppRoutes.servicesRoute + AppRoutes.manageServicesRoute,
    );
  }
}

@immutable
abstract class ServicesPreviewState {}
