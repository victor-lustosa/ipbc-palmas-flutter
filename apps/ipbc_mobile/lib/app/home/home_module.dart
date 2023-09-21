import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import '../lyric/lyric_module.dart';

import '../service/service_module.dart';
import '../service/views/service_view.dart';
import '../service/views/services_collection_view.dart';
import '../service/views/services_list_view.dart';
import 'view-models/home_view_model.dart';
import 'views/home_view.dart';
import 'views/init_view.dart';

class HomeModule extends Module {
  static const String initialRoute = '/';
  static const String homeRoute = '/home';
  static const String serviceRoute = '/service';
  static const String servicesListRoute = '/services';
  static const String servicesCollectionRoute = '/services-collection';

  @override
  void binds(Injector i) {
    i.add(HomeViewModel.new);
  }

  @override
  List<Module> get imports => [LyricModule(), ServiceModule()];

  @override
  void routes(r) {
    r.child(
      initialRoute,
      child: (_) => const InitView(),
      children: [
        ChildRoute(
          homeRoute,
           transition: TransitionType.custom,
           child: (_) => const HomeView(),
            customTransition: CustomTransition(
              transitionDuration: const Duration(milliseconds: 700),
              reverseTransitionDuration: const Duration(milliseconds: 700),
              transitionBuilder: (context, anim1, anim2, child) {
                return SlideTransition(
                  position: anim1.drive(Tween(begin: const Offset(1, 0), end: Offset.zero).chain(CurveTween(curve: Curves.ease))),
                  child: child,
                );
              },
            ),
        ),
        ChildRoute(
          servicesListRoute,
          transition: TransitionType.custom,
          child: (_) => const ServicesListView(),
          customTransition: CustomTransition(
            transitionDuration: const Duration(milliseconds: 700),
            reverseTransitionDuration: const Duration(milliseconds: 700),
            transitionBuilder: (context, anim1, anim2, child) {
              return SlideTransition(
                position: anim1.drive(Tween(begin: const Offset(1, 0), end: Offset.zero).chain(CurveTween(curve: Curves.ease))),
                child: child,
              );
            },
          ),
        ),
        ChildRoute(
          servicesCollectionRoute,
          transition: TransitionType.custom,
          child: (_) => ServicesCollectionView(entity: r.args.data as ServicesEntity,),
          customTransition: CustomTransition(
            transitionDuration: const Duration(milliseconds: 700),
            reverseTransitionDuration: const Duration(milliseconds: 700),
            transitionBuilder: (context, anim1, anim2, child) {
              return SlideTransition(
                position: anim1.drive(Tween(begin: const Offset(1, 0), end: Offset.zero).chain(CurveTween(curve: Curves.ease))),
                child: child,
              );
            },
          ),
        ),
        ChildRoute(
          serviceRoute,
          transition: TransitionType.custom,
          child: (_) => ServiceView(entity: r.args.data as ServiceViewDTO,),
          customTransition: CustomTransition(
            transitionDuration: const Duration(milliseconds: 700),
            reverseTransitionDuration: const Duration(milliseconds: 700),
            transitionBuilder: (context, anim1, anim2, child) {
              return SlideTransition(
                position: anim1.drive(Tween(begin: const Offset(1, 0), end: Offset.zero).chain(CurveTween(curve: Curves.ease))),
                child: child,
              );
            },
          ),
        ),
      ],
    );
  }
}
