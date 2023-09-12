
import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import '../lyric/views/lyric_view.dart';
import '../../../app/exception/views/unknown_route_view.dart';
import '../service/views/services_list_view.dart';

class AppRoutes {
  AppRoutes._();

  static final GlobalKey<NavigatorState> _androidNavigatorKey =
      GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> getAndroidNavigatorKey() {
    return _androidNavigatorKey;
  }

  static const String initialRoute = "/";
  static const String lyricRoute = "/lyric";

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case lyricRoute:
        return CustomTransitionPageRoute(
          transitionSpeed: const Duration(milliseconds: 500),
          reverseSpeed: const Duration(milliseconds: 500),
          child: LyricView(entity: settings.arguments as LyricEntity),
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
      key:  null,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case AppRoutes.initialRoute:
              return CupertinoPageRoute(
                settings: settings,
                builder: (_) => const CupertinoPageScaffold(child: ServicesListView()),
              );
          default:
            return unknownRoute();
        }
      },
    );
  }
}

unknownRoute() {
    return CupertinoPageRoute(
      builder: (_) => const CupertinoPageScaffold(child: UnknownRouteView()),
    );
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
