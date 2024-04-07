import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../core_module.dart';

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
  final Duration? transitionSpeed;
  final Duration? reverseSpeed;

  CustomTransitionPageRoute(
      { this.transitionSpeed,
         this.reverseSpeed,
        required this.tween,
        required this.child})
      : super(
      reverseTransitionDuration: reverseSpeed ?? const Duration(milliseconds: 300),
      transitionDuration: transitionSpeed ?? const Duration(milliseconds: 300),
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
