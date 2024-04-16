import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../core_module.dart';

class AppRoutes {
  factory AppRoutes() {
    _singleton ??= AppRoutes._();
    return _singleton!;
  }

  AppRoutes._();

  static AppRoutes? _singleton;

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
          builder: (_) => const CupertinoPageScaffold(child: UnknownRouteView()));
    } else {
      return MaterialPageRoute(builder: (_) => const UnknownRouteView());
    }
  }
}



class CustomTransitionPageRoute extends PageRouteBuilder {
  final Widget child;
  final Animatable<Offset> tween;
  final Duration? transitionSpeed;
  final Duration? reverseSpeed;

  CustomTransitionPageRoute(
      {this.transitionSpeed,
      this.reverseSpeed,
      required this.tween,
      required this.child})
      : super(
            reverseTransitionDuration:
                reverseSpeed ?? const Duration(milliseconds: 300),
            transitionDuration:
                transitionSpeed ?? const Duration(milliseconds: 300),
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
