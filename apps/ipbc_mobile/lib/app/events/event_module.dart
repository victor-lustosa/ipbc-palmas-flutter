import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';

import 'views/create_event_view.dart';
import 'views/events_list_view.dart';




class EventModule extends Module {
  static const String eventsListRoute = '/events-list';
  static const String createEventRoute = '/create-event';
  static const String eventRoute = '/event';

  @override
  List<Module> get imports => [
    LyricModule(),
    ServiceModule(),
  ];

  @override
  void binds(Injector i) {

  }

  @override
  void routes(r) {
    r.child(eventsListRoute, child: (_) => const EventsListView());
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
                Tween(begin: const Offset(1, 0), end: Offset.zero)
                    .chain(CurveTween(curve: Curves.ease))),
            child: child,
          );
        },
      ),
    );
  }
}
