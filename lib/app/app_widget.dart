import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipbc_palmas/app/home/views/home_view.dart';

import 'lyric/infra/repositories/lyric_repository.dart';
import 'lyric/views/lyrics_list_view.dart';
import 'shared/configs/app_routes.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key, required this.lyricRepository}) : super(key: key);
  final LyricRepository lyricRepository;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: lyricRepository,
        child: MaterialApp(
            title: 'IPBC Palmas',
            theme: ThemeData(
              primarySwatch: Colors.grey,
            ),
            home: const LyricsListView(),
            initialRoute: "/",
            onGenerateRoute: AppRoutes.onGenerateRoute,
            debugShowCheckedModeBanner: false));
  }
}
