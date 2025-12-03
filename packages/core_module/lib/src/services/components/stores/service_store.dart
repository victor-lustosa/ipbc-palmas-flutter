import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

class ServiceStore extends ValueNotifier<GenericState<ServiceState>> {
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
  List<LyricEntity> entitiesList = [];
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
    pushNamed(AppRoutes.servicesRoute + AppRoutes.manageServicesRoute);
  }

  Future<void> addLyric() async {
    _manageLyricStore.buttonCallback = () {
      final index = entitiesList.indexWhere(
        (item) => item.id == _manageLyricStore.lyric.value.id,
      );
      if (index != -1) {
        entitiesList[index] = _manageLyricStore.lyric.value;
      } else {
        entitiesList.add(_manageLyricStore.lyric.value);
      }
      popUntil(
        (route) =>
            route.settings.name ==
            AppRoutes.servicesRoute + AppRoutes.serviceRoute,
      );
    };
    pushNamed(
      AppRoutes.servicesRoute + AppRoutes.searchLyricsRoute,
      arguments: SearchLyricsDTO(
        servicesEntity: servicesEntity,
        serviceId: serviceEntity.id!,
      ),
    );
  }

  void editLyric(BuildContext context) {
    manageLyricStore.isEditing = true;
    manageLyricStore.lyric.value = lyricsListStore.selectedLyric;
    pushNamed(AppRoutes.servicesRoute + AppRoutes.manageLyricsRoute);
    pop(context);
  }

  void deleteLyric(BuildContext context) async {
    lyricsListStore.tappedIndex.value = null;
    manageLyricStore.deleteLyric(
      context: context,
      params: {
        'table': 'service_lyrics',
        'match': {
          'service_id': int.parse(serviceEntity.id!),
          'lyric_id': int.parse(lyricsListStore.selectedLyric.id!),
        },
      },
      isAttached: true,
    );
    entitiesList.remove(
      entitiesList.firstWhere((e) => e.id == lyricsListStore.selectedLyric.id!),
    );
    manageLyricStore.value = RefreshingState();
    nativePopToast(2, context);
  }
}

@immutable
abstract class ServiceState {}
