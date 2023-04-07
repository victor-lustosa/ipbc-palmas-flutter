import 'dart:io';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ipbc_palmas/app/exception/view/unknown_route_view.dart';

import '../../lyric/domain/entities/lyric_entity.dart';
import '../../lyric/domain/entities/service_entity.dart';
import '../../lyric/presentation/views/service_view.dart';
import '../../lyric/presentation/views/lyric_view.dart';
import '../../lyric/presentation/views/services_colletions_view.dart';
import '../../lyric/presentation/views/services_list_view.dart';

class AppRoutes {
  AppRoutes._();

  static final GlobalKey<NavigatorState> _androidNavigatorKey =
      GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> getAndroidNavigatorKey() {
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
        if (Platform.isIOS) {
          return CupertinoPageRoute(
            builder: (_) => const CupertinoPageScaffold(
              child: UnknownRouteView(),
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => const UnknownRouteView(),
          );
        }
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
            if (Platform.isIOS) {
              return CupertinoPageRoute(
                builder: (_) => const CupertinoPageScaffold(
                  child: UnknownRouteView(),
                ),
              );
            } else {
              return MaterialPageRoute(
                builder: (_) => const UnknownRouteView(),
              );
            }
        }
      },
    );
  }
}

class CustomTransitionPageRoute extends PageRouteBuilder {
  final Widget child;
  late Animatable<Offset> tween;
  CustomTransitionPageRoute({required this.child})
      : super(
            reverseTransitionDuration: const Duration(milliseconds: 800),
            transitionDuration: const Duration(milliseconds: 800),
            pageBuilder: (context, animation, secondaryAnimation) => child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;

    const curve = Curves.easeInOutQuint;
    tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
/*  ScaleTransition(
        scale : animation,
        child: child,
     );*/
}
