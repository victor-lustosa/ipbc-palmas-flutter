import 'dart:io';

import 'package:flutter/material.dart';
import '../lyric_module.dart';
import 'ui/blocs/lyric_bloc.dart';
import 'ui/views/lyric_view.dart';

class LyricModule extends Module {
  static const String initialRoute = "/";
  static const String lyricRoute = "/lyric";
  static const String lyricsRoute = "/lyrics";
  static const String lyricsListRoute = "/lyrics-list";

  @override
  void exportedBinds(i) {
    i.addSingleton<LyricBloc>(
      () => LyricBloc(
        supaUseCase: LyricsUseCases(
          repository: i.get<Repository<List<dynamic>>>(),
        ),
      ),
      config: CoreModule.blocConfig(),
    );
  }

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(r) {
    r.child(
      lyricRoute,
      transition: TransitionType.custom,
      child: (_) => LyricView(
        entity: r.args.data as LyricEntity,
      ),
      customTransition: CustomTransition(
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: anim1.drive(
              Tween(begin: const Offset(0, 1), end: Offset.zero).chain(
                CurveTween(curve: Curves.ease),
              ),
            ),
            child: child,
          );
        },
      ),
    );
  }
}

class NativeLyricRoutes extends StatefulWidget {
  const NativeLyricRoutes({super.key});

  @override
  State<NativeLyricRoutes> createState() => _NativeLyricRoutesState();
}

class _NativeLyricRoutesState extends State<NativeLyricRoutes> {
  final GlobalKey<NavigatorState> _androidNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'lyric_key');

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Platform.isIOS ? null : _androidNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case LyricModule.initialRoute:
            return customTransitionRoute(
              child: const LyricsListView(),
              tween: Tween(begin: const Offset(0, 0), end: Offset.zero).chain(
                CurveTween(curve: Curves.ease),
              ),
            );
          default:
            return unknownRoute();
        }
      },
    );
  }
}
