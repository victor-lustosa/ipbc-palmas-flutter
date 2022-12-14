import 'package:flutter/material.dart';
import 'lyric/lyric_module.dart';
import 'shared/configs/no_glow_behavior.dart';
import 'lyric/views/lyrics_list_view.dart';
import 'shared/configs/app_colors.dart';
import 'shared/configs/app_routes.dart';
import 'package:provider/provider.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [...lyricModule],
        child: MaterialApp(
            builder: (context, Widget? child) {
              return ScrollConfiguration(
                behavior: NoGlowBehavior(),
                child: child!,
              );
            },
            title: 'IPBC Palmas',
            theme: ThemeData(
              primaryColor: AppColors.white,
            ),
            home: const LyricsListView(),
            initialRoute: "/",
            onGenerateRoute: AppRoutes.onGenerateRoute,
            debugShowCheckedModeBanner: false));
  }
}
