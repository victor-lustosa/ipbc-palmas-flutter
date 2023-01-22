// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart'
    hide CupertinoTabBar, CupertinoTabScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../configs/app_configs.dart';
import '../bottom-bar/custom_bottom_tab_bar.dart';
import '../bottom-bar/custom_tab_scaffold.dart';

class CupertinoBottomBarWidget extends StatefulWidget {
  int selectedIndex;

  final Function(int) callback;

  CupertinoBottomBarWidget({
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
        items: [
          BottomNavigationBarItem(
            icon: widget.selectedIndex == 0
                ? SizedBox(
                    width: 25,
                    height: 25,
                    child: SvgPicture.asset(
                      color: AppColors.darkGreen,
                      AppIcons.home,
                      matchTextDirection: true,
                    ),
                  )
                : SizedBox(
                    width: 25,
                    height: 25,
                    child: SvgPicture.asset(
                      color: AppColors.grey,
                      AppIcons.home,
                      matchTextDirection: true,
                    ),
                  ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: widget.selectedIndex == 1
                ? SizedBox(
                    width: 25,
                    height: 25,
                    child: SvgPicture.asset(
                      color: AppColors.darkGreen,
                      AppIcons.lyricsIconName,
                      matchTextDirection: true,
                    ),
                  )
                : SizedBox(
                    width: 25,
                    height: 25,
                    child: SvgPicture.asset(
                      color: AppColors.grey,
                      AppIcons.lyricsIconName,
                      matchTextDirection: true,
                    ),
                  ),
            label: 'Músicas',
          ),
          BottomNavigationBarItem(
            icon: widget.selectedIndex == 2
                ? SizedBox(
                    width: 25,
                    height: 25,
                    child: SvgPicture.asset(
                      color: AppColors.darkGreen,
                      AppIcons.volunteerActivism,
                      matchTextDirection: true,
                    ),
                  )
                : SizedBox(
                    width: 25,
                    height: 25,
                    child: SvgPicture.asset(
                      color: AppColors.grey,
                      AppIcons.volunteerActivism,
                      matchTextDirection: true,
                    ),
                  ),
            label: 'Ofertas',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          routes: {
            //'p2': (context) => PageTwo(),
          },
          builder: (context) {
            return CupertinoPageScaffold(
              child: Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(
                          () {
                            widget.callback(widget.selectedIndex);
                          },
                        );
                      },
                      child: Text('Next Page'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
