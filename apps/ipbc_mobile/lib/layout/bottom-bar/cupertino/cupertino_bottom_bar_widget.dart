// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart' hide CupertinoTabBar, CupertinoTabScaffold;

import '../../../app/configs/app_routes.dart';
import '../../../app/exception/views/unknown_route_view.dart';
import '../../../app/home/home_module.dart';
import '../../../app/lyric/lyric_module.dart';
import '../../../app/lyric/views/lyric_view.dart';
import '../../../app/lyric/views/lyrics_list_view.dart';
import '../../../app/offers/views/offers_view.dart';
import '../buttons_bar_mixin.dart';

import 'custom_tab_scaffold.dart';
import 'custom_bottom_tab_bar.dart';

class CupertinoBottomBarWidget extends StatefulWidget {
  final int selectedIndex;

  final Function(int) callback;

  const CupertinoBottomBarWidget({
    Key? key,
    required this.selectedIndex,
    required this.callback,
  }) : super(key: key);

  @override
  State<CupertinoBottomBarWidget> createState() => _CupertinoBottomBarWidgetState();
}

class _CupertinoBottomBarWidgetState extends State<CupertinoBottomBarWidget>
    with ButtonsBarMixin {
  @override
  initState() {
    super.initState();
    buildButtonsBar();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        height: 45,
        currentIndex: widget.selectedIndex,
        activeColor: AppColors.darkGreen,
        backgroundColor: AppColors.white,
        items: buttons,
        onTap: (newValue) {
          setState(
            () {
              widget.callback(newValue);
            },
          );
        },
      ),
      tabBuilder: (__, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              onGenerateRoute: (RouteSettings settings) {
                switch (settings.name) {
                  case LyricModule.lyricRoute:
                    return CustomTransitionPageRoute(
                      transitionSpeed: const Duration(milliseconds: 500),
                      reverseSpeed: const Duration(milliseconds: 500),
                      child: LyricView(entity: settings.arguments as LyricEntity),
                      tween: Tween(begin: const Offset(0, 1), end: Offset.zero).chain(CurveTween(curve: Curves.ease)),
                    );
                  default:
                    return unknownRoute();
                }
              },
              builder: (context) {
                return cupertinoView(const HomeRoutes());
              },
            );
          case 1:
            return cupertinoView(const LyricsListView());

          case 2:
            return cupertinoView(const OffersView());

          default:
            return cupertinoView(const UnknownRouteView());
        }
      },
    );
  }

  Widget cupertinoView(Widget view) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: AppColors.white,
      ),
      child: view,
    );
  }
}
