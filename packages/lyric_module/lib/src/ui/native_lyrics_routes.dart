import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../lyric_module.dart';

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
          case AppRoutes.rootRoute:
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
