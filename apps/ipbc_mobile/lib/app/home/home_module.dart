import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../offers/controller/banner_controller.dart';
import '../service/views/admin/insert_services_view.dart';
import '../service/views/services_collection_view.dart';
import '../service/views/services_list_view.dart';
import '../service/views/service_view.dart';
import '../service/service_module.dart';
import '../lyric/lyric_module.dart';
import '../configs/app_routes.dart';

import 'blocs/home_bloc.dart';
import 'views/home_view.dart';
import 'views/init_view.dart';

class HomeModule extends Module {
  static const String initialRoute = '/';
  static const String homeRoute = '/home';
  static const String serviceRoute = '/service';
  static const String servicesListRoute = '/services';
  static const String servicesCollectionRoute = '/services-collection';

  static final GlobalKey<NavigatorState> _androidNavigatorKey = GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> getAndroidNavigatorKey() => _androidNavigatorKey;

  @override
  List<Module> get imports => [LyricModule(), ServiceModule()];
 @override
  void binds(Injector i) {
   i.addLazySingleton<HomeBloc>(
         () => HomeBloc(
       supaUseCases: ServicesUseCases(repository: i.get<Repository<List<dynamic>>>()),
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
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Platform.isIOS ? null : AppRoutes.getAndroidNavigatorKey(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case HomeModule.initialRoute:
            if (Platform.isIOS) {
              return CupertinoPageRoute(
                settings: settings,
                builder: (_) => const CupertinoPageScaffold(child: HomeView()),
              );
            } else {
              return MaterialPageRoute(
                settings: settings,
                builder: (_) => const HomeView(),
              );
            }

          case HomeModule.servicesListRoute:
            return CustomTransitionPageRoute(
              transitionSpeed: const Duration(milliseconds: 700),
              reverseSpeed: const Duration(milliseconds: 700),
              child: ServicesListView(entitiesList: Modular.args.data ?? []),
              tween: Tween(begin: const Offset(1, 0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.ease)),
            );

          case ServiceModule.serviceRoute:
            return CustomTransitionPageRoute(
              transitionSpeed: const Duration(milliseconds: 700),
              reverseSpeed: const Duration(milliseconds: 700),
              child: ServiceView(entity: settings.arguments as ServiceViewDTO),
              tween: Tween(begin: const Offset(1, 0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.ease)),
            );

          case ServiceModule.servicesCollectionRoute:
            return CustomTransitionPageRoute(
              transitionSpeed: const Duration(milliseconds: 700),
              reverseSpeed: const Duration(milliseconds: 700),
              child: ServicesCollectionView(
                entity: settings.arguments as ServicesEntity,
              ),
              tween: Tween(begin: const Offset(1, 0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.ease)),
            );

          case ServiceModule.insertServicesRoute:
            return CustomTransitionPageRoute(
              transitionSpeed: const Duration(milliseconds: 700),
              reverseSpeed: const Duration(milliseconds: 700),
              child: const InsertServicesView(),
              tween: Tween(begin: const Offset(1, 0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.ease)),
            );

          default:
            return unknownRoute();
        }
      },
    );
  }
}
