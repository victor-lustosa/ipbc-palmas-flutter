import 'package:core_module/core_module.dart';
import 'package:events_module/src/ui/views/events_detail.dart';
import 'package:flutter/cupertino.dart';

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
      customTransition: CustomTransition(
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: anim1.drive(
              Tween(begin: const Offset(1, 0), end: Offset.zero).chain(
                CurveTween(curve: Curves.ease),
              ),
            ),
            child: child,
          );
        },
      ),
    );
    r.child(
      detailEventRoute,
      transition: TransitionType.custom,
      child: (_) => const EventsDetailView(),
      customTransition: CustomTransition(
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: anim1.drive(
              Tween(begin: const Offset(1, 0), end: Offset.zero).chain(
                CurveTween(curve: Curves.ease),
              ),
            ),
            child: child,
          );
        },
      ),
    );
  }
}
