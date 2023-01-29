import 'package:flutter/material.dart';

import '../../lyric/presentation/views/chosen_lyrics_list_view.dart';
import '../../lyric/presentation/views/weekday_lyrics_list_view.dart';
import '../../shared/configs/app_routes.dart';

class WeekdaysLyricsRouters extends StatefulWidget {
  const WeekdaysLyricsRouters({super.key});

  @override
  State<WeekdaysLyricsRouters> createState() => _WeekdaysLyricsRouterState();
}

GlobalKey<NavigatorState> _coffeeNavigatorKey = GlobalKey<NavigatorState>();

class _WeekdaysLyricsRouterState extends State<WeekdaysLyricsRouters> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _coffeeNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/':
                  return WeekdayLyricsListView();
                case AppRoutes.chosenLyricsRoute:
                  return ChosenLyricsListView();
                default:
                  return const SizedBox(
                    child: Text("Deu errado rota"),
                  );
              }
            });
      },
    );
  }
}
