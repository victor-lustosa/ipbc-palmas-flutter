// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart'
    hide CupertinoTabBar, CupertinoTabScaffold;
import 'package:design_system/design_system.dart';

import '../../../../configs/app_routes.dart';
import '../../../../offers/views/offers_view.dart';
import '../../../../shared/mixins/buttons_bar_mixin.dart';
import '../../../../exception/views/unknown_route_view.dart';
import '../../../../lyric/presentation/views/lyrics_list_view.dart';

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
  State<CupertinoBottomBarWidget> createState() =>
      _CupertinoBottomBarWidgetState();
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
        height: 60,
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
              onGenerateRoute: AppRoutes.onGenerateRoute,
              builder: (context) {
                return const CupertinoPageScaffold(
                    navigationBar: CupertinoNavigationBar(
                      backgroundColor: Color(0xFFFFFFFF),
                    ),
                    child: ServicesListRoutes());
              },
            );
          case 1:
            return const CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  backgroundColor: Color(0xFFFFFFFF),
                ),
                child: LyricsListView());

          case 2:
            return const CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  backgroundColor: Color(0xFFFFFFFF),
                ),
                //child: NoConnectionView(index: 0,)
                child: OffersView());

          default:
            return const CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  backgroundColor: Color(0xFFFFFFFF),
                ),
                child: UnknownRouteView());
        }
      },
    );
  }
}
