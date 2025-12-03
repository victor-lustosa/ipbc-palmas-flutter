import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core_module.dart';

class AppRoutes {
  //Init
  static const String initialRoute = '/init';

  //Home
  static const String homeRoute = '/home';
  static const String rootRoute = '/';

  //Auth
  static const String authRoute = '/auth';
  static const String loginRoute = '/login';
  static const String createAccountRoute = '/create-account';
  static const String verificationCodeRoute = '/verification-code';
  static const String creatingNewPassWordRoute = '/creating-new-password';
  static const String resetPasswordSuccessRoute = '/success-password';
  static const String resetPasswordRoute = '/reset-password';
  static const String registrationCompletionRoute = '/registration-Completion';
  static const String accountCreatedRoute = '/account-created';
  static const String couldNotCreateRoute = '/could-not-create-account';

  //Services
  static const String serviceRoute = '/service';
  static const String manageServicesRoute = "/manage-services";
  static const String manageLyricsFadeRoute = "/manage-lyrics-fade";
  static const String manageLyricsSlideRoute = "/manage-lyrics-slide";
  static const String searchLyricsRoute = "/search-lyrics";
  static const String servicesCollectionRoute = "/services-collection";
  static const String servicesListRoute = '/services-list';
  static const String servicesRoute = '/services';

  //events
  static const String eventsListRoute = '/events-list';
  static const String createEventRoute = '/create-event';
  static const String detailEventRoute = '/detail-event';
  static const String eventRoute = '/event';

  //Lyrics
  static const String lyricRoute = "/lyric";
  static const String lyricsRoute = "/lyrics";
  static const String lyricsListRoute = "/lyrics-list";
}

Future<void> nativePushReplacementNamed(
  String route,
  BuildContext context, {
  Object? arguments,
}) async {
  Navigator.pushReplacementNamed(context, route, arguments: arguments);
}

Future<void> pushReplacementNamed(String route, {Object? arguments}) async {
  Modular.to.pushReplacementNamed(route, arguments: arguments);
}

Future<void> pushNamedAndRemoveUntil(
  String route,
  bool Function(Route<dynamic>) predicate, {
  Object? arguments,
}) async {
  Modular.to.pushNamedAndRemoveUntil(route, predicate, arguments: arguments);
}

void navigate(String route, {Object? arguments}) {
  Modular.to.navigate(route, arguments: arguments);
}

Future<void> nativePushNamed(
  String route,
  BuildContext context, {
  Object? arguments,
}) async {
  Navigator.pushNamed(context, route, arguments: arguments);
}

Future<void> pushNamed(String route, {Object? arguments}) async {
  Modular.to.pushNamed(route, arguments: arguments);
}

void popUntil(bool Function(Route<dynamic>) predicate) {
  Modular.to.popUntil(predicate);
}

void popToast(int popNumber) {
  int count = 0;
  popUntil((_) => count++ >= popNumber);
}

void nativePopToast(int popNumber, BuildContext context) {
  int count = 0;
  nativePopUntil((_) => count++ >= popNumber, context);
}

void nativePopUntil(
  bool Function(Route<dynamic>) predicate,
  BuildContext context,
) {
  Navigator.popUntil(context, predicate);
}

void nativePop(BuildContext context) {
  Navigator.pop(context);
}

Future<void> nativePopAndPushNamed(
  BuildContext context,
  String routeName, {
  dynamic result,
  Object? arguments,
}) async {
  Navigator.popAndPushNamed(
    context,
    routeName,
    result: result,
    arguments: arguments,
  );
}

Future<void> popAndPushNamed(
  String routeName, {
  dynamic result,
  Object? arguments,
}) async {
  Modular.to.popAndPushNamed(routeName, result: result, arguments: arguments);
}

void pop([BuildContext? context]) {
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
         pageBuilder: (_, _, _) => child,
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

/*class ModularFadeTransition extends CustomTransition {
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
}*/

class ModularSlideTransition extends CustomTransition {
  ModularSlideTransition({
    Duration? transitionDuration,
    Duration? reverseTransitionDuration,
    Curve? curve,
    Offset? begin,
    Offset? end,
    bool? opaque,
    Offset? secondaryBegin,
  }) : super(
         transitionDuration:
             transitionDuration ?? const Duration(milliseconds: 300),
         reverseTransitionDuration:
             reverseTransitionDuration ?? const Duration(milliseconds: 300),
         transitionBuilder: (context, anim1, anim2, child) {
           // Vai da direita (Offset(1,0)) para o centro (Offset.zero)
           final inTween = Tween(
             begin: begin ?? const Offset(1, 0),
             end: end ?? Offset.zero,
           ).chain(CurveTween(curve: curve ?? Curves.easeOut));
           // Vai do centro (Offset.zero) para um pouco à esquerda (Offset(-0.3, 0))
           // O valor -0.3 é um bom valor visual, mas você pode ajustar.
           final outTween = Tween(
             begin: Offset.zero,
             end: secondaryBegin ?? const Offset(-0.3, 0),
           ).chain(CurveTween(curve: curve ?? Curves.easeOut));
           return SlideTransition(
             position: anim2.drive(outTween),
             child: SlideTransition(
               position: anim1.drive(inTween),
               child: child,
             ),
           );
         },
       );
}
/*
class UniversalPageRoute extends PageRouteBuilder {
  final Widget child;
  final AnimationType enterType;
  final AnimationType? exitType;

  UniversalPageRoute({
    required this.child,
    required this.enterType,
    this.exitType,
    Duration duration = const Duration(milliseconds: 300),
  }) : super(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionDuration: duration,
    reverseTransitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final bool isPopping = animation.status == AnimationStatus.reverse;
      final type = (isPopping && exitType != null) ? exitType : enterType;

      return UniversalModularTransition._applyAnimation(
          type,
          animation,
          child,
          Curves.easeInOut
      );
    },
  );
}*/

enum AnimationType { slideRight, slideUp, fade, scale, none }

class UniversalModularTransition extends CustomTransition {
  UniversalModularTransition({
    required AnimationType enterType,
    AnimationType? exitType,
    Duration? duration,
    Duration? reverseDuration,
    Curve curve = Curves.easeOut,
    Offset? begin,
    Offset? end,
    bool? opaque,
    Offset? secondaryBegin,
  }) : super(
         transitionDuration: duration ?? const Duration(milliseconds: 300),
         reverseTransitionDuration: reverseDuration ?? const Duration(milliseconds: 300),
          opaque: opaque ?? true,
         transitionBuilder: (context, animation, secondaryAnimation, child) {
           final bool isPopping = animation.status == AnimationStatus.reverse;

           final AnimationType activeType = (isPopping && exitType != null)
               ? exitType
               : enterType;

           return _applyAnimation(
             activeType,
             animation,
             secondaryAnimation,
             child,
             curve,
             begin,
             end,
             opaque,
             secondaryBegin,
           );
         },
       );

  static Widget _applyAnimation(
    AnimationType type,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
    Curve curve,
    Offset? begin,
    Offset? end,
    bool? opaque,
    Offset? secondaryBegin,
  ) {
    switch (type) {

      case AnimationType.slideRight:
        final inTween = Tween(
          begin: begin ?? const Offset(1, 0),
          end: end ?? Offset.zero,
        ).chain(CurveTween(curve: curve));
        // Vai do centro (Offset.zero) para um pouco à esquerda (Offset(-0.3, 0))
        // O valor -0.3 é um bom valor visual, mas você pode ajustar.
        final outTween = Tween(
          begin: Offset.zero,
          end: secondaryBegin ?? const Offset(-1, 0),
        ).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(outTween),
          child: SlideTransition(
            position: secondaryAnimation.drive(inTween),
            child: child,
          ),
        );

      case AnimationType.slideUp:
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: Offset.zero,
          ).chain(CurveTween(curve: curve)).animate(animation),
          child: child,
        );

      case AnimationType.fade:
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: curve),
          child: child,
        );

      case AnimationType.scale:
        return ScaleTransition(
          scale: CurvedAnimation(parent: animation, curve: curve),
          child: child,
        );

      case AnimationType.none:
        return child;
    }
  }
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
         pageBuilder: (_, _, _) => child,
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
