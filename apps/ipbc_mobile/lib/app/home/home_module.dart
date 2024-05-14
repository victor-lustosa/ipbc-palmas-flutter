import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../events/event_module.dart';
import '../events/views/events_list_view.dart';
import '../offers/controller/banner_controller.dart';

import 'blocs/home_bloc.dart';
import 'views/home_view.dart';

class HomeModule extends Module {
  static const String homeRoute = '/home';
  static const String initialRoute = '/';

  @override
  List<Module> get imports => [ServiceModule()];

  @override
  void binds(Injector i) {
    i.addSingleton(
      () => ServicesUseCases(
        repository: i.get<Repository<List<dynamic>>>(),
      ),
    );
    i.addLazySingleton<HomeBloc>(
      () => HomeBloc(
        supaUseCases: i.get<ServicesUseCases>(),
      ),
      config: CoreModule.blocConfig(),
    );
    i.addLazySingleton<BannerController>(BannerController.new);
  }
}

class NativeHomeRoutes extends StatefulWidget {
  const NativeHomeRoutes({super.key});

  @override
  State<NativeHomeRoutes> createState() => _NativeHomeRoutesState();
}

class _NativeHomeRoutesState extends State<NativeHomeRoutes> {
  final GlobalKey<NavigatorState> _androidNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home_key');

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Platform.isIOS ? null : _androidNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case HomeModule.homeRoute || HomeModule.initialRoute:
            return customTransitionRoute(
              child: const HomeView(),
            );

          case ServiceModule.serviceRoute:
            return customTransitionRoute(
              child: ServiceView(
                entity: settings.arguments as ServiceViewDTO,
              ),
            );

          case ServiceModule.servicesListRoute:
            return customTransitionRoute(
              child: ServicesListView(
                entities: settings.arguments as List<ServicesEntity>,
              ),
            );

          case ServiceModule.servicesCollectionRoute:
            return customTransitionRoute(
              child: ServicesCollectionView(
                entity: settings.arguments as ServicesEntity,
              ),
            );

          case ServiceModule.editLiturgiesRoute:
            return customTransitionRoute(
              child: EditLiturgyView(
                dto: settings.arguments as EditLiturgyDTO,
              ),
            );

          case EventModule.eventsListRoute:
            return customTransitionRoute(
              child: const EventsListView(),
              tween: Tween(begin: const Offset(0, 0), end: Offset.zero).chain(
                CurveTween(curve: Curves.ease),
              ),
            );
          default:
            return unknownRoute();
        }
      },
    );
  }

}
