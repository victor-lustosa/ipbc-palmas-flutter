import 'package:core_module/core_module.dart';
import 'package:events_module/src/ui/blocs/events_list_bloc.dart';
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

  }

  @override
  void routes(r) {
    r.child(
      AppRoutes.createEventRoute,
      transition: TransitionType.custom,
      child: (_) => const CreateEventView(),
      customTransition: UniversalModularTransition(
        enterType: .fade,
        duration: Duration(milliseconds: 150),
        reverseDuration: Duration(milliseconds: 150),
      ),
    );
    r.child(
      AppRoutes.detailEventRoute,
      transition: TransitionType.custom,
      child: (_) => EventsDetailView(eventEntity: r.args.data as EventEntity),
      customTransition: UniversalModularTransition(
        enterType: .fade,
        duration: Duration(milliseconds: 150),
        reverseDuration: Duration(milliseconds: 150),
      ),
    );
  }
}
