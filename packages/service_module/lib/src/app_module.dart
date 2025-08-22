import 'package:core_module/core_module.dart';
import 'package:service_module/src/ui/views/admin/search_lyrics_view.dart';
import 'package:service_module/src/ui/views/admin/services_preview_view.dart';
import '../service_module.dart';
import 'ui/blocs/services_collection_bloc.dart';
import 'ui/views/admin/manage_lyric_view.dart';

class ServiceModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<ServicesCollectionBloc>(
      () => ServicesCollectionBloc(editStore: Modular.get<ManageServiceStore>(),
        onlineUseCases: i.get<UseCases<SupabaseRepository>>(),
      ),
      config: CoreModule.blocConfig(),
    );

  }

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(r) {
    r.child(
      AppRoutes.manageLyricsRoute,
      transition: TransitionType.custom,
      child: (_) => ManageLyricView(),
      customTransition: ModularSlideTransition(),
    );
    r.child(
      AppRoutes.manageServicesRoute,
      transition: TransitionType.custom,
      child: (_) => ManageServiceView(),
      customTransition: ModularFadeTransition(),
    );
    r.child(
      AppRoutes.servicesPreviewRoute,
      transition: TransitionType.custom,
      child: (_) => ServicesPreviewView(),
      customTransition: ModularFadeTransition(),
    );
    r.child(
      AppRoutes.searchLyricsRoute,
      transition: TransitionType.custom,
      child: (_) => SearchLyricsView(),
      customTransition: ModularFadeTransition(),
    );
  }
}
