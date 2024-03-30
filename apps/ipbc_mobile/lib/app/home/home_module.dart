import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../events/views/events_list_view.dart';
import '../offers/controller/banner_controller.dart';

import '../splash/splash_module.dart';
import 'blocs/home_bloc.dart';
import 'views/home_view.dart';
import 'views/init_view.dart';

class HomeModule extends Module {
  static const String initialRoute = '/';

  @override
  List<Module> get imports => [
        LyricModule(),
        ServiceModule(),
      ];

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

  @override
  void routes(r) {
    r.child(initialRoute, child: (_) => const InitView());
  }
}

class HomeRoutes extends StatefulWidget {
  const HomeRoutes({super.key});

  @override
  State<HomeRoutes> createState() => _HomeRoutesState();
}

class _HomeRoutesState extends State<HomeRoutes> {
  final GlobalKey<NavigatorState> _androidNavigatorKey =
  GlobalKey<NavigatorState>(debugLabel: 'home_key');

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Platform.isIOS ? null : _androidNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case HomeModule.initialRoute:
            if (Platform.isIOS) {
              return CupertinoPageRoute(
                settings: settings,
                builder: (_) => const CupertinoPageScaffold(
                  child: HomeView(),
                ),
              );
            } else {
              return MaterialPageRoute(
                settings: settings,
                builder: (_) => const HomeView(),
              );
            }

          case ServiceModule.serviceRoute:
            return CustomTransitionPageRoute(
              transitionSpeed: const Duration(milliseconds: 700),
              reverseSpeed: const Duration(milliseconds: 700),
              child: ServiceView(
                  entity: settings.arguments as ServiceViewDTO),
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

          case ServiceModule.editLiturgiesRoute:
            return CustomTransitionPageRoute(
              transitionSpeed: const Duration(milliseconds: 700),
              reverseSpeed: const Duration(milliseconds: 700),
              child: EditLiturgiesView(dto: settings.arguments as EditLiturgiesDTO,),
              tween: Tween(begin: const Offset(1, 0), end: Offset.zero).chain(
                CurveTween(curve: Curves.ease),
              ),
            );

          case SplashModule.eventsListRoute:
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
