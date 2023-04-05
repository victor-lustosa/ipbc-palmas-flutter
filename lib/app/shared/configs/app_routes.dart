import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../lyric/domain/entities/lyric_entity.dart';
import '../../lyric/domain/entities/service_entity.dart';
import '../../lyric/presentation/views/service_view.dart';
import '../../lyric/presentation/views/lyric_view.dart';
import '../../lyric/presentation/views/services_colletions_view.dart';
import '../../lyric/presentation/views/services_list_view.dart';

class AppRoutes {
  AppRoutes._();

  static final GlobalKey<NavigatorState> _androidNavigatorKey = GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> getAndroidNavigatorKey(){
    return _androidNavigatorKey;
  }

  static const String initialRoute = "/";
  static const String serviceRoute = "/service-view";
  static const String lyricsListRoute = "/lyrics-list-view";
  static const String lyricRoute = "/lyric-view";
  static const String servicesCollectionsRoute = "/services-collections-view";
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case lyricRoute:
        if (Platform.isIOS) {
          return CupertinoPageRoute(
            builder: (_) => CupertinoPageScaffold(
              child: LyricView(
                lyricEntity: (routeSettings.arguments as LyricEntity),
              ),
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => LyricView(
              lyricEntity: (routeSettings.arguments as LyricEntity),
            ),
          );
        }
      default:
        return UnknownRoute._get();
    }
  }
}

class ServicesListRoutes extends StatefulWidget {
  const ServicesListRoutes({super.key});

  @override
  State<ServicesListRoutes> createState() => _ServicesListRoutesState();
}

class _ServicesListRoutesState extends State<ServicesListRoutes> {

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Platform.isIOS ? null : AppRoutes.getAndroidNavigatorKey(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case AppRoutes.initialRoute:
            if (Platform.isIOS) {
              return CupertinoPageRoute(
                builder: (_) => const CupertinoPageScaffold(
                  child: ServicesListView(),
                ),
              );
            } else {
              return MaterialPageRoute(
                settings: settings,
                builder: (_) => const ServicesListView(),
              );
            }
          case AppRoutes.serviceRoute:
            if (Platform.isIOS) {
              return CupertinoPageRoute(
                builder: (_) => CupertinoPageScaffold(
                  child: ServiceView(
                    entity: (settings.arguments as ServiceViewDTO),
                  ),
                ),
              );
            } else {
              return MaterialPageRoute(
                settings: settings,
                builder: (_) => ServiceView(
                  entity: (settings.arguments as ServiceViewDTO),
                ),
              );
            }
          case AppRoutes.servicesCollectionsRoute:
            if (Platform.isIOS) {
              return CupertinoPageRoute(
                builder: (_) => CupertinoPageScaffold(
                  child: ServicesCollectionsView(
                    serviceCollections: (settings.arguments as ServiceCollectionsDTO)
                  ),
                ),
              );
            } else {
              return MaterialPageRoute(
                settings: settings,
                builder: (_) => ServicesCollectionsView(
                    serviceCollections: (settings.arguments as ServiceCollectionsDTO)
                ),
              );
            }
          case AppRoutes.lyricRoute:
            if (Platform.isIOS) {
              return CupertinoPageRoute(
                builder: (_) => CupertinoPageScaffold(
                  child: LyricView(lyricEntity: settings.arguments as LyricEntity),
                ),
              );
            } else {
              return MaterialPageRoute(
                builder: (_) => LyricView(lyricEntity: settings.arguments as LyricEntity),
              );
            }
          default:
            return UnknownRoute._get();
        }
      },
    );
  }
}

class UnknownRoute {
  static Route<dynamic> _get() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Rota não encontrada"),
          ),
          body: const Center(
            child: Text("tela não encontrada"),
          ),
        );
      },
    );
  }
}
/* Route pushServicesCollectionsRoutes(ServiceCollectionsDTO service) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>  ServicesCollectionsView(serviceCollections: service),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}*/