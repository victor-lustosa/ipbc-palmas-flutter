import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../core_module.dart';

nativeNavigate(
  String route,
  BuildContext context, {
  Object? arguments,
}) {
  Navigator.pushReplacementNamed(context, route, arguments: arguments);
}

navigate(
  String route, {
  Object? arguments,
}) {
  Modular.to.navigate(route, arguments: arguments);
}

nativePushNamed(
  String route,
  BuildContext context, {
  Object? arguments,
}) {
  Navigator.pushNamed(context, route, arguments: arguments);
}

pushNamed(
  String route, {
  Object? arguments,
}) {
  Modular.to.pushNamed(route, arguments: arguments);
}

nativePop(BuildContext context) {
  Navigator.pop(context);
}

pop(BuildContext context) {
  Modular.to.pop(context);
}

PageRoute unknownRoute() {
  if (Platform.isIOS) {
    return CupertinoPageRoute(
      builder: (_) => const CupertinoPageScaffold(
        child: UnknownRouteView(),
      ),
    );
  } else {
    return MaterialPageRoute(builder: (_) => const UnknownRouteView());
  }
}

class SlideTransitionPage extends PageRouteBuilder {
  final Widget child;
  final Curve? curve;
  final Offset? begin;
  final Offset? end;

  SlideTransitionPage({
    Duration? transitionSpeed,
    Duration? reverseSpeed,
    this.curve,
    this.begin,
    this.end,
    required this.child,
  }) : super(
          reverseTransitionDuration:
              reverseSpeed ?? const Duration(milliseconds: 300),
          transitionDuration:
              transitionSpeed ?? const Duration(milliseconds: 300),
          pageBuilder: (_, __, ___) => child,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      SlideTransition(
        position: animation.drive(
          Tween(
            begin: begin ?? const Offset(1, 0),
            end: end ?? Offset.zero,
          ).chain(
            CurveTween(curve: curve ?? Curves.ease),
          ),
        ),
        child: child,
      );
/*  ScaleTransition(
        scale : animation,
        child: child,
     );*/
/*FadeTransition(opacity: animation, child: child);*/
}

class FadeTransitionPage extends PageRouteBuilder {
  final Widget child;
  final Curve? curve;

  FadeTransitionPage({
    Duration? transitionSpeed,
    Duration? reverseSpeed,
    this.curve,
    required this.child,
  }) : super(
          reverseTransitionDuration:
              reverseSpeed ?? const Duration(milliseconds: 300),
          transitionDuration:
              transitionSpeed ?? const Duration(milliseconds: 300),
          pageBuilder: (_, __, ___) => child,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      RotationTransition(
        turns: animation,
        child: child,
      );
/*  ScaleTransition(
        scale : animation,
        child: child,
     );*/
/*FadeTransition(opacity: animation, child: child);*/
}
