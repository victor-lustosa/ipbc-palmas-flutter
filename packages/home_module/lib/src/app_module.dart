import 'dart:io';

import 'package:auth_module/auth_module.dart';
import 'package:events_module/events_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offers_module/offers_module.dart';
import 'package:service_module/service_module.dart';

import '../home_module.dart';
import 'ui/views/home_view.dart';
import 'ui/views/init_view.dart';

class InitModule extends Module {
  @override
  List<Module> get imports => [
    HomeModule(),
    CoreModule(),
    LyricModule(),
    AuthModule(),
  ];

  @override
  void routes(r) {
    r.child(AppRoutes.initialRoute, child: (_) => const InitView());
    r.module(AppRoutes.authRoute, module: AuthModule());
    r.module(AppRoutes.lyricsRoute, module: LyricModule());
    r.module(AppRoutes.servicesRoute, module: ServiceModule());
    r.module(AppRoutes.eventRoute, module: EventModule());
  }
}

class HomeModule extends Module {
  @override
  List<Module> get imports => [ServiceModule(), OffersModule(), CoreModule()];

  @override
  void binds(Injector i) {
    i.addLazySingleton<HomeBloc>(
      () => HomeBloc(useCases: i.get<UseCases<SupabaseRepository>>()),
      config: CoreModule.blocConfig(),
    );
  }
}

class NativeHomeRoutes extends StatefulWidget {
  const NativeHomeRoutes({super.key});

  @override
  State<NativeHomeRoutes> createState() => _NativeHomeRoutesState();
}

class _NativeHomeRoutesState extends State<NativeHomeRoutes> {
  final GlobalKey<NavigatorState> _androidNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'home_key');

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Platform.isIOS ? null : _androidNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case AppRoutes.homeRoute || AppRoutes.rootRoute:
            return CustomFadeTransition(child: const HomeView());

          case AppRoutes.serviceRoute:
            return CustomFadeTransition(
              child: ServiceView(entity: settings.arguments as ServiceViewDTO),
            );

          case AppRoutes.servicesListRoute:
            return CustomFadeTransition(
              child: ServicesListView(
                entities: settings.arguments as List<ServicesEntity>,
              ),
            );

          case AppRoutes.servicesCollectionRoute:
            return CustomSlideTransition(
              child: ServicesCollectionView(
                entity: settings.arguments as ServicesEntity,
              ),
            );

          case AppRoutes.editLiturgiesRoute:
            return CustomFadeTransition(
              child: EditLiturgyView(dto: settings.arguments as EditLiturgyDTO),
            );

          case AppRoutes.eventsListRoute:
            return CustomFadeTransition(child: const EventsListView());

          case AppRoutes.detailEventRoute:
            return CustomFadeTransition(
              child: EventsDetailView(
                eventEntity: settings.arguments as EventEntity,
              ),
            );

          default:
            return unknownRoute();
        }
      },
    );
  }
}
