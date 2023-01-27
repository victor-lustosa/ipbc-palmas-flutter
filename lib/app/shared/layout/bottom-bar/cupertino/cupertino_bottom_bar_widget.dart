// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart'
    hide CupertinoTabBar, CupertinoTabScaffold;
import 'package:ipbc_palmas/app/lyric/presentation/views/lyrics_list_view.dart';
import 'package:ipbc_palmas/app/lyric/presentation/views/offering_view.dart';
import 'package:ipbc_palmas/app/lyric/presentation/views/weekday_lyrics_list_view.dart';
import 'package:ipbc_palmas/app/shared/configs/app_routes.dart';
import '../../../configs/app_configs.dart';
import '../navegation_button_widget.dart';
import 'custom_bottom_tab_bar.dart';
import 'custom_tab_scaffold.dart';

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

class _CupertinoBottomBarWidgetState extends State<CupertinoBottomBarWidget> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: widget.selectedIndex,
        activeColor: AppColors.darkGreen,
        backgroundColor: AppColors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: NavegationButtonWidget(
              iconName: AppIcons.home,
              color: AppColors.darkGreen,
            ),
            icon: NavegationButtonWidget(
              iconName: AppIcons.home,
              color: AppColors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: NavegationButtonWidget(
              iconName: AppIcons.lyricsIconName,
              color: AppColors.darkGreen,
            ),
            icon: NavegationButtonWidget(
              iconName: AppIcons.lyricsIconName,
              color: AppColors.grey,
            ),
            label: 'Músicas',
          ),
          BottomNavigationBarItem(
            activeIcon: NavegationButtonWidget(
              iconName: AppIcons.volunteerActivism,
              color: AppColors.darkGreen,
            ),
            icon: NavegationButtonWidget(
              iconName: AppIcons.volunteerActivism,
              color: AppColors.grey,
            ),
            label: 'Ofertas',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              onGenerateRoute: AppRoutes.onGenerateRoute,
              builder: (context) {
                return CupertinoPageScaffold(
                    navigationBar: const CupertinoNavigationBar(
                      backgroundColor: Color(0xFFFFFFFF),
                    ),
                    child: WeekdayLyricsListView());
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
                child: OfferingView());

          default:
            return Center(
              child: Text('Pagina nao encontrada'),
            );
        }
      },
    );
  }
}
