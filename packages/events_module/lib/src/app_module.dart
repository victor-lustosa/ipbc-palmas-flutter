import 'package:core_module/core_module.dart';

import 'ui/views/create_event_view.dart';

class EventModule extends Module {
  static const String eventsListRoute = '/events-list';
  static const String createEventRoute = '/create-event';
  static const String detailEventRoute = '/detail-event';
  static const String eventRoute = '/event';

  @override
  void routes(r) {
    r.child(
      createEventRoute,
      transition: TransitionType.custom,
      child: (_) => const CreateEventView(),
      customTransition: ModularFadeTransition()
    );
  }
}
