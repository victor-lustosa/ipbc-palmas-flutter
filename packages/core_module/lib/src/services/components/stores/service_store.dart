import 'package:flutter/cupertino.dart';
import 'package:core_module/core_module.dart';

class ServiceStore
    extends ValueNotifier<GenericState<ServiceState>> {
  ServiceStore({
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

  void addLyric() {
    manageLyricStore.serviceId = serviceEntity.id!;
    pushNamed(
      AppRoutes.servicesRoute +
          AppRoutes.searchLyricsRoute,
    );
  }

  void editLyric(BuildContext context) {
    manageLyricStore.isEditing = true;
    pushNamed(
      AppRoutes.servicesRoute +
          AppRoutes.manageLyricsRoute,
      arguments:
      lyricsListStore.lyricEntity,
    );
    pop(context);
  }

  void deleteLyric(BuildContext context) {
    manageLyricStore.delete(lyricId: lyricsListStore.lyricEntity.id!);
  }
}

@immutable
abstract class ServiceState {}
