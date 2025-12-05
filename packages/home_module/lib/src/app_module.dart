import 'package:auth_module/auth_module.dart';
import 'package:events_module/events_module.dart';
import 'package:home_module/src/ui/blocs/home_bloc.dart';
import 'package:offers_module/offers_module.dart';
import 'package:service_module/service_module.dart';

import '../home_module.dart';
import 'ui/views/init_view.dart';

class InitModule extends Module {
  @override
  List<Module> get imports => [
    HomeModule(),
    CoreModule(),
    LyricModule(),
    AuthModule(),
    EventModule(),
  ];

  @override
  void routes(r) {
    r.child(AppRoutes.initialRoute, child: (_) => const InitView());
    r.module(AppRoutes.authRoute, module: AuthModule());
    r.module(AppRoutes.lyricsRoute, module: LyricModule());
    r.module(AppRoutes.servicesRoute, module: ServiceModule());
    r.module(AppRoutes.eventRoute, module: EventModule());
    r.wildcard(child: (_) => const InitView());
  }
}

class HomeModule extends Module {
  @override
  List<Module> get imports => [ServiceModule(), OffersModule(), CoreModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton<DetailEventStore>(() => DetailEventStore(
          useCases: i.get<UseCases<SupabaseRepository>>(),
        ),
    );
    i.addLazySingleton<HomeBloc>(
      () => HomeBloc(
        useCases: i.get<UseCases<SupabaseRepository>>(),
        createEventStore: i.get<CreateEventStore>(),
        authCircleAvatarStore: i.get<AuthCircleAvatarStore>(),
        detailEventStore: i.get<DetailEventStore>()
      ),
      config: CoreModule.blocConfig(),
    );
  }
}
