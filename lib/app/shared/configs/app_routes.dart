import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ipbc_palmas/app/lyric/domain/entities/lyric_entity.dart';
import 'package:ipbc_palmas/app/lyric/presentation/views/lyric_view.dart';

import '../../home/views/home_view.dart';
import '../../lyric/presentation/views/lyrics_list_view.dart';

class AppRoutes {
  static const String initialRoute = "/";
  static const String homeRoute = "/home";
  static const String lyricsRoute = "/lyrics";
  static const String lyricRoute = "/lyric-view";

  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    //final arguments = routeSettings.arguments;

    switch (routeSettings.name) {
      //case homeRoute:
      //return MaterialPageRoute(builder: (_) => const HomeView());

      case initialRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());

      case lyricsRoute:
        if (Platform.isIOS) {
          return CupertinoPageRoute(
              builder: (_) => const CupertinoPageScaffold(
                    navigationBar: CupertinoNavigationBar(
                      backgroundColor: Colors.white,
                    ),
                    child: LyricsListView(),
                  ));
        } else {
          return MaterialPageRoute(builder: (_) => const LyricsListView());
        }
      case lyricRoute:
        if (Platform.isIOS) {
          return CupertinoPageRoute(
            builder: (_) => CupertinoPageScaffold(
              navigationBar: const CupertinoNavigationBar(
                backgroundColor: Colors.white,
              ),
              child: LyricView(
                lyricEntity: (routeSettings.arguments as LyricEntity),
              ),
            ),
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => LyricView(
              lyricEntity: (routeSettings.arguments as LyricEntity),
            ),
          );
        }

      default:
        return _unknownRoute();
    }
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
