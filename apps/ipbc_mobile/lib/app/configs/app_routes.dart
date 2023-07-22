import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ipbc_palmas/app/lyric/views/admin/insert_lyrics_view.dart';

import '../lyric/views/lyric_view.dart';
import '../lyric/views/service_view.dart';
import '../lyric/views/services_list_view.dart';
import '../lyric/views/services_collection_view.dart';
import '../../../app/exception/views/unknown_route_view.dart';

class AppRoutes {
  AppRoutes._();

  static final GlobalKey<NavigatorState> _androidNavigatorKey =
      GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> getAndroidNavigatorKey() {
    return _androidNavigatorKey;
  }

  static const String initialRoute = "/";
  static const String insertLyricsRoute = "/insert-lyrics";
  static const String serviceRoute = "/service";
  static const String lyricsListRoute = "/lyrics-list";
  static const String lyricRoute = "/lyric";
  static const String servicesCollectionRoute = "/services-collection";

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case lyricRoute:
        return CustomTransitionPageRoute(
          transitionSpeed: const Duration(milliseconds: 500),
          reverseSpeed: const Duration(milliseconds: 500),
          child: LyricView(lyricEntity: settings.arguments as LyricEntity),
          tween: Tween(begin: const Offset(0, 1), end: Offset.zero)
              .chain(CurveTween(curve: Curves.ease)),
        );
      default:
        return unknownRoute();
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
                settings: settings,
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
            return CustomTransitionPageRoute(
              transitionSpeed: const Duration(milliseconds: 700),
              reverseSpeed: const Duration(milliseconds: 700),
              child: ServiceView(entity: settings.arguments as ServiceViewDTO),
              tween: Tween(begin: const Offset(1, 0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.ease)),
            );

          case AppRoutes.servicesCollectionRoute:
            return CustomTransitionPageRoute(
              transitionSpeed: const Duration(milliseconds: 700),
              reverseSpeed: const Duration(milliseconds: 700),
              child: ServicesCollectionView(
                servicesCollection: settings.arguments as ServicesEntity,
              ),
              tween: Tween(begin: const Offset(1, 0), end: Offset.zero)
                  .chain(CurveTween(curve: Curves.ease)),
            );

          case AppRoutes.insertLyricsRoute:
            return CustomTransitionPageRoute(
              transitionSpeed: const Duration(milliseconds: 700),
              reverseSpeed: const Duration(milliseconds: 700),
              child: const InsertLyricsView(),
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

unknownRoute() {
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

class CustomTransitionPageRoute extends PageRouteBuilder {
  final Widget child;
  final Animatable<Offset> tween;
  final Duration transitionSpeed;
  final Duration reverseSpeed;

  CustomTransitionPageRoute(
      {required this.transitionSpeed,
      required this.reverseSpeed,
      required this.tween,
      required this.child})
      : super(
            reverseTransitionDuration: reverseSpeed,
            transitionDuration: transitionSpeed,
            pageBuilder: (context, animation, secondaryAnimation) => child);

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
  /*FadeTransition(opacity: animation, child: child);*/
}
