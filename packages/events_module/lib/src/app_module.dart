import 'package:core_module/core_module.dart';
import '../events_module.dart';
import 'ui/views/create_event_view.dart';

class EventModule extends Module {

  @override
  void routes(r) {
    r.child(AppRoutes.createEventRoute,
        transition: TransitionType.custom,
        child: (_) => const CreateEventView(),
        customTransition: ModularFadeTransition());
    r.child(
      AppRoutes.detailEventRoute,
      transition: TransitionType.custom,
      child: (_) => EventsDetailView(
        eventEntity: r.args.data as EventEntity,
      ),
      customTransition: ModularFadeTransition(),
    );
  }
}
