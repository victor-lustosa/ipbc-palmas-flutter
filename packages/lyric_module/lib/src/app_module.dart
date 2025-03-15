import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../lyric_module.dart';
import 'ui/blocs/lyric_bloc.dart';
import 'ui/views/lyric_view.dart';

class LyricModule extends Module {

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
    r.child(
      lyricsListRoute,
      transition: TransitionType.custom,
      child: (_) => const LyricsListView(),
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
