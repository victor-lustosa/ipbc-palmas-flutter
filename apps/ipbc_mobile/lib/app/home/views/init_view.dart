import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../events/event_module.dart';
import '../../events/views/events_list_view.dart';

import '../../offers/views/offers_view.dart';
import '../views/home_view.dart';
import '../home_module.dart';

class InitView extends StatefulWidget {
  const InitView({super.key});

  @override
  State<InitView> createState() => _InitViewState();
}

class _InitViewState extends State<InitView> {

  int selectedIndex = 0;

  final _controller = PageController();

  void _onItemTapped(int index) {
    selectedIndex = index;
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOutQuint,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(
              () {
                selectedIndex = index;
              },
            );
          },
          children: const [
            HomeRoutes(),
            LyricRoutes(),
            OffersView(),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedBuilder(
        animation: _controller,
        builder: (__, _) {
          return MaterialBottomBarWidget(
            selectedIndex: selectedIndex,
            callback: (int index) {
              setState(
                () {
                  _onItemTapped(index);
                },
              );
            },
          );
        },
      ),
    );
  }
}
class LyricRoutes extends StatefulWidget {
  const LyricRoutes({super.key});

  @override
  State<LyricRoutes> createState() => _LyricRoutesState();
}

class _LyricRoutesState extends State<LyricRoutes> {
  final GlobalKey<NavigatorState> _androidNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'lyric_key');

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Platform.isIOS ? null : _androidNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case LyricModule.initialRoute:
              return CustomTransitionPageRoute(
                child: const LyricsListView(),
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

class HomeRoutes extends StatefulWidget {
  const HomeRoutes({super.key});

  @override
  State<HomeRoutes> createState() => _HomeRoutesState();
}

class _HomeRoutesState extends State<HomeRoutes> {
  final GlobalKey<NavigatorState> _androidNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home_key');

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Platform.isIOS ? null : _androidNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case HomeModule.initialRoute:
            return CustomTransitionPageRoute(
              child: const HomeView(),
              tween: Tween(begin: const Offset(0, 0), end: Offset.zero).chain(
                CurveTween(curve: Curves.ease),
              ),
            );

          case ServiceModule.serviceRoute:
            return CustomTransitionPageRoute(
              transitionSpeed: const Duration(milliseconds: 700),
              reverseSpeed: const Duration(milliseconds: 700),
              child: ServiceView(entity: settings.arguments as ServiceViewDTO),
              tween: Tween(begin: const Offset(1, 0), end: Offset.zero).chain(
                CurveTween(curve: Curves.ease),
              ),
            );

          case ServiceModule.servicesListRoute:
            return CustomTransitionPageRoute(
              transitionSpeed: const Duration(milliseconds: 700),
              reverseSpeed: const Duration(milliseconds: 700),
              child: ServicesListView(
                  entities: settings.arguments as List<ServicesEntity>),
              tween: Tween(begin: const Offset(1, 0), end: Offset.zero).chain(
                CurveTween(curve: Curves.ease),
              ),
            );

          case ServiceModule.servicesCollectionRoute:
            return CustomTransitionPageRoute(
              transitionSpeed: const Duration(milliseconds: 700),
              reverseSpeed: const Duration(milliseconds: 700),
              child: ServicesCollectionView(
                entity: settings.arguments as ServicesEntity,
              ),
              tween: Tween(begin: const Offset(1, 0), end: Offset.zero).chain(
                CurveTween(curve: Curves.ease),
              ),
            );

          case EventModule.eventsListRoute:
            return CustomTransitionPageRoute(
              transitionSpeed: const Duration(milliseconds: 700),
              reverseSpeed: const Duration(milliseconds: 700),
              child: const EventsListView(),
              tween: Tween(begin: const Offset(1, 0), end: Offset.zero).chain(
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
