import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'dart:io';

import '../../lyric/domain/entities/lyric_entity.dart';
import '../../lyric/presentation/views/chosen_lyrics_list_view.dart';
import '../../lyric/presentation/views/lyric_view.dart';
import '../../lyric/presentation/views/weekend_lyrics_list_view.dart';
import '../../shared/configs/app_routes.dart';

class WeekdendLyricsRouters extends StatefulWidget {
  const WeekdendLyricsRouters({super.key});

  @override
  State<WeekdendLyricsRouters> createState() => _WeekendLyricsRouterState();
}

class _WeekendLyricsRouterState extends State<WeekdendLyricsRouters> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case AppRoutes.initialRoute:
            if (Platform.isIOS) {
              return CupertinoPageRoute(
                builder: (_) => const CupertinoPageScaffold(
                  child: WeekendLyricsListView(),
                ),
              );
            } else {
              return MaterialPageRoute(
                settings: settings,
                builder: (_) => const WeekendLyricsListView(),
              );
            }
          case AppRoutes.chosenLyricsRoute:
            if (Platform.isIOS) {
              return CupertinoPageRoute(
                builder: (_) => CupertinoPageScaffold(
                  child: ChosenLyricsListView(
                    url: (settings.arguments as WeekendModel).url,
                    heading: (settings.arguments as WeekendModel).heading,
                  ),
                ),
              );
            } else {
              return MaterialPageRoute(
                settings: settings,
                builder: (_) => ChosenLyricsListView(
                  url: (settings.arguments as WeekendModel).url,
                  heading: (settings.arguments as WeekendModel).heading,
                ),
              );
            }
          case AppRoutes.lyricRoute:
            if (Platform.isIOS) {
              return CupertinoPageRoute(
                builder: (_) => CupertinoPageScaffold(
                  child:
                      LyricView(lyricEntity: settings.arguments as LyricEntity),
                ),
              );
            } else {
              return MaterialPageRoute(
                settings: settings,
                builder: (_) =>
                    LyricView(lyricEntity: settings.arguments as LyricEntity),
              );
            }
          default:
            return _unknownRoute();
        }
      },
    );
  }

  static Route<dynamic> _unknownRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Rota não encontrada"),
          ),
          body: const Center(
            child: Text("tela não encontrada"),
          ),
        );
      },
    );
  }
}
