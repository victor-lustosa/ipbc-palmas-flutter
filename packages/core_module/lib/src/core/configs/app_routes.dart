import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../core_module.dart';

nativePushReplacementNamed(String route, BuildContext context, {Object? arguments}) {
  Navigator.pushReplacementNamed(context, route, arguments: arguments);
}

pushReplacementNamed(String route, {Object? arguments}){
  Modular.to.pushReplacementNamed(route, arguments: arguments);
}
navigate(String route, {Object? arguments}) {
  Modular.to.navigate(route, arguments: arguments);
}

nativePushNamed(String route, BuildContext context, {Object? arguments}) {
  Navigator.pushNamed(context, route, arguments: arguments);
}

pushNamed(String route, {Object? arguments}) {
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
      builder: (_) => const CupertinoPageScaffold(child: UnknownRouteView()),
    );
  } else {
    return MaterialPageRoute(builder: (_) => const UnknownRouteView());
  }
}

class CustomSlideTransition extends PageRouteBuilder {
  final Widget child;
  final Curve? curve;
  final Offset? begin;
  final Offset? end;

  CustomSlideTransition({
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
  ) => SlideTransition(
    position: animation.drive(
      Tween(
        begin: begin ?? const Offset(1, 0),
        end: end ?? Offset.zero,
      ).chain(CurveTween(curve: curve ?? Curves.ease)),
    ),
    child: child,
  );
  /*  ScaleTransition(
        scale : animation,
        child: child,
     );*/
  /*FadeTransition(opacity: animation, child: child);*/
}

class ModularFadeTransition extends CustomTransition {
  ModularFadeTransition({
    Duration? transitionDuration,
    Duration? reverseTransitionDuration,
    bool? opaque,
  }) : super(
         transitionBuilder: (context, anim1, anim2, child) {
           return FadeTransition(opacity: anim1, child: child);
         },
         transitionDuration:
             transitionDuration ?? const Duration(milliseconds: 150),
         reverseTransitionDuration:
             reverseTransitionDuration ?? const Duration(milliseconds: 150),
         opaque: opaque ?? true,
       );
}

class ModularSlideTransition extends CustomTransition {
  ModularSlideTransition({
    Duration? transitionDuration,
    Duration? reverseTransitionDuration,
    Curve? curve,
    Offset? begin,
    Offset? end,
    bool? opaque,
  }) : super(
         transitionBuilder: (context, anim1, anim2, child) {
           return SlideTransition(
             position: anim1.drive(
               Tween(
                 begin: begin ?? const Offset(1, 0),
                 end: end ?? Offset.zero,
               ).chain(CurveTween(curve: curve ?? Curves.ease)),
             ),
             child: child,
           );
         },
         transitionDuration:
             transitionDuration ?? const Duration(milliseconds: 300),
         reverseTransitionDuration:
             reverseTransitionDuration ?? const Duration(milliseconds: 300),
         opaque: opaque ?? true,
       );
}

class CustomFadeTransition extends PageRouteBuilder {
  final Widget child;

  CustomFadeTransition({
    Duration? transitionSpeed,
    Duration? reverseSpeed,
    required this.child,
  }) : super(
         reverseTransitionDuration:
             reverseSpeed ?? const Duration(milliseconds: 150),
         transitionDuration:
             transitionSpeed ?? const Duration(milliseconds: 150),
         pageBuilder: (_, __, ___) => child,
       );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) => FadeTransition(opacity: animation, child: child);
  /*  ScaleTransition(
        scale : animation,
        child: child,
     );*/
  /*FadeTransition(opacity: animation, child: child);*/
}
