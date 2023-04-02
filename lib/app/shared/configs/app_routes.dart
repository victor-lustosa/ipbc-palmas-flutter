import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import '../../lyric/domain/entities/lyric_entity.dart';
import '../../lyric/domain/entities/service_entity.dart';
import '../../lyric/presentation/views/service_view.dart';
import '../../lyric/presentation/views/lyric_view.dart';
import '../../lyric/presentation/views/services_colletions_view.dart';
import '../../lyric/presentation/views/services_list_view.dart';

class AppRoutes {
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
  State<ServicesListRoutes> createState() => _WeekendLyricsRoutesState();
}

class _WeekendLyricsRoutesState extends State<ServicesListRoutes> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
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
                    service: (settings.arguments as ServiceEntity),
                  ),
                ),
              );
            } else {
              return MaterialPageRoute(
                settings: settings,
                builder: (_) => ServiceView(
                  service: (settings.arguments as ServiceEntity),
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
                builder: (_) => ServiceView(
                  service: (settings.arguments as ServiceEntity),
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
