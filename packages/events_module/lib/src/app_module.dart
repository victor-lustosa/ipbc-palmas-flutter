import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

import 'ui/views/create_event_view.dart';

class EventModule extends Module {
  static const String eventsListRoute = '/events-list';
  static const String createEventRoute = '/create-event';
  static const String eventRoute = '/event';

  @override
  void routes(r) {
    r.child(
      createEventRoute,
      transition: TransitionType.custom,
      child: (_) => const CreateEventView(),
      customTransition: CustomTransition(
        transitionDuration: const Duration(milliseconds: 100),
        reverseTransitionDuration: const Duration(milliseconds: 100),
        transitionBuilder: (context, anim1, anim2, child) {
          return FadeTransition(
            opacity: anim1,
            child: child,
          );
        },
      ),
    );
  }
}
