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
  void routes(r) {
    r.child(AppRoutes.lyricRoute,
        transition: TransitionType.custom,
        child: (_) => LyricView(
              entity: r.args.data as LyricEntity,
            ),
        customTransition: ModularSlideTransition());
  }
}
