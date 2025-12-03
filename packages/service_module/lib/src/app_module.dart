import 'package:core_module/core_module.dart';
import 'package:service_module/src/ui/views/admin/search_lyrics_view.dart';

import '../service_module.dart';
import 'ui/blocs/services_collection_bloc.dart';

class ServiceModule extends Module {
  @override
  void binds(i) {
    i.addLazySingleton<ServicesCollectionBloc>(
      () => ServicesCollectionBloc(
        lyricsListStore: Modular.get<LyricsListStore>(),
        manageServiceStore: Modular.get<ManageServiceStore>(),
        serviceStore: i.get<ServiceStore>(),
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
      AppRoutes.manageServicesRoute,
      transition: TransitionType.custom,
      child: (_) => ManageServiceView(),
      customTransition: UniversalModularTransition(
        enterType: .fade,
        duration: Duration(milliseconds: 150),
        reverseDuration: Duration(milliseconds: 150),
      ),
    );
    r.child(
      AppRoutes.serviceRoute,
      transition: TransitionType.custom,
      child: (_) => ServiceView(),
      customTransition: UniversalModularTransition(
        enterType: .fade,
        duration: Duration(milliseconds: 150),
        reverseDuration: Duration(milliseconds: 150),
      ),
    );
    r.child(
      AppRoutes.searchLyricsRoute,
      transition: TransitionType.custom,
      child: (_) => SearchLyricsView(dto: r.args.data as SearchLyricsDTO),
      customTransition: UniversalModularTransition(
        enterType: .fade,
        duration: Duration(milliseconds: 150),
        reverseDuration: Duration(milliseconds: 150),
      ),
    );
  }
}
