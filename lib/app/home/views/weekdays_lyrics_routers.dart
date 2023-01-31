import 'package:flutter/material.dart';
import 'package:ipbc_palmas/app/lyric/domain/entities/lyric_entity.dart';
import 'package:ipbc_palmas/app/lyric/presentation/views/lyrics_list_view.dart';

import '../../lyric/presentation/views/chosen_lyrics_list_view.dart';
import '../../lyric/presentation/views/lyric_view.dart';
import '../../lyric/presentation/views/weekday_lyrics_list_view.dart';
import '../../shared/configs/app_routes.dart';

class WeekdaysLyricsRouters extends StatefulWidget {
  const WeekdaysLyricsRouters({super.key});

  @override
  State<WeekdaysLyricsRouters> createState() => _WeekdaysLyricsRouterState();
}

GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

class _WeekdaysLyricsRouterState extends State<WeekdaysLyricsRouters> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch (settings.name) {
              case AppRoutes.initialRoute:
                return WeekdayLyricsListView();

              case AppRoutes.chosenLyricsRoute:
                return ChosenLyricsListView();

              case AppRoutes.lyricRoute:
                return LyricView(
                    lyricEntity: settings.arguments as LyricEntity);

              default:
                return const SizedBox(
                  child: Text("Deu errado rota"),
                );
            }
          },
        );
      },
    );
  }
}
