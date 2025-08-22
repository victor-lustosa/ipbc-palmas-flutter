import 'package:core_module/core_module.dart';
import 'package:events_module/src/ui/blocs/events_list_bloc.dart';
import 'package:events_module/src/ui/stores/create_event_store.dart';
import '../events_module.dart';
import 'ui/views/create_event_view.dart';

class EventModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton<EventsListBloc>(
      () => EventsListBloc(
        onlineUseCases: i.get<UseCases<SupabaseRepository>>(),
        slideCardsStore: Modular.get<SlideCardsStore>(),
        createEventStore: Modular.get<CreateEventStore>(),
      ),
      config: CoreModule.blocConfig(),
    );
    i.addLazySingleton(
      () => CreateEventStore(useCases: i.get<UseCases<SupabaseRepository>>()),
    );
  }

  @override
  void routes(r) {
    r.child(
      AppRoutes.createEventRoute,
      transition: TransitionType.custom,
      child: (_) => const CreateEventView(),
      customTransition: ModularFadeTransition(),
    );
    r.child(
      AppRoutes.detailEventRoute,
      transition: TransitionType.custom,
      child: (_) => EventsDetailView(eventEntity: r.args.data as EventEntity),
      customTransition: ModularFadeTransition(),
    );
  }
}
