import 'dart:io';

import 'package:events_module/events_module.dart';
import 'package:flutter/material.dart';
import 'package:home_module/src/ui/views/home_view.dart';
import 'package:service_module/service_module.dart';

import '../../home_module.dart';

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
              child: EditLiturgyView(),
            );

          case AppRoutes.eventRoute + AppRoutes.eventsListRoute:
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
