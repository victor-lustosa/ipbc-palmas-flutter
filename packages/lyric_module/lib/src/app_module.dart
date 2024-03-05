import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'ui/views/lyric_view.dart';

import 'ui/blocs/lyric_bloc.dart';

class LyricModule extends Module {
  static const String initialRoute = "/";
  static const String lyricRoute = "/lyric";
  static const String lyricsRoute = "/lyrics";

  @override
  void exportedBinds(i) {
    i.addSingleton<LyricBloc>(
      () => LyricBloc(
        supaUseCase: LyricsUseCases(repository: i.get<Repository<List<dynamic>>>()),
      ),
      config: CoreModule.blocConfig(),
    );
  }

  @override
  List<Module> get imports => [CoreModule(), ServiceModule()];

  @override
  void routes(r) {
    r.child(
      lyricRoute,
      transition: TransitionType.custom,
      child: (_) => LyricView(entity: r.args.data as LyricEntity),
      customTransition: CustomTransition(
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: anim1.drive(
                Tween(begin: const Offset(0, 1), end: Offset.zero)
                    .chain(CurveTween(curve: Curves.ease))),
            child: child,
          );
        },
      ),
    );
  }
}
