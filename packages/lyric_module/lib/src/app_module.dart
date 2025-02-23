import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

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
        useCases: i.get<UseCases<SupabaseRepository>>(),
        lyricUseCases: LyricsUseCases(),
      ),
      config: CoreModule.blocConfig(),
    );
  }

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(r) {
    r.child(lyricRoute,
        transition: TransitionType.custom,
        child: (_) => LyricView(
              entity: r.args.data as LyricEntity,
            ),
        customTransition: ModularSlideTransition());
  }
}

class NativeLyricRoutes extends StatefulWidget {
  const NativeLyricRoutes({super.key});

  @override
  State<NativeLyricRoutes> createState() => _NativeLyricRoutesState();
}

class _NativeLyricRoutesState extends State<NativeLyricRoutes> {
  final GlobalKey<NavigatorState> _androidNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'lyric_key');

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Platform.isIOS ? null : _androidNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case LyricModule.initialRoute:
            return CustomSlideTransition(
              child: const LyricsListView(),
              begin: const Offset(0, 0),
              end: Offset.zero,
            );
          default:
            return unknownRoute();
        }
      },
    );
  }
}
