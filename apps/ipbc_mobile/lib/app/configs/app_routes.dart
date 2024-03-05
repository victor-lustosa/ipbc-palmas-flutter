import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppRoutes {
  AppRoutes._();

  static final GlobalKey<NavigatorState> _androidNavigatorKey = GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> getAndroidNavigatorKey() {
    return _androidNavigatorKey;
  }
}

unknownRoute() {
  if (Platform.isIOS) {
    return CupertinoPageRoute(builder: (_) => const CupertinoPageScaffold(child: UnknownRouteView()));
  } else {
    return MaterialPageRoute(builder: (_) => const UnknownRouteView());
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
