import 'dart:io';

import 'package:flutter/cupertino.dart' hide CupertinoTabBar, CupertinoTabScaffold;
import '../../shared/components/bottom_bar/custom_bottom_tab_bar.dart';
import '../../shared/components/bottom_bar/custom_tab_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:ipbc_palmas/app/lyric/presentation/views/lyric_view.dart';
import 'package:ipbc_palmas/app/lyric/presentation/views/lyrics_list_view.dart';
import 'package:ipbc_palmas/app/shared/configs/app_configs.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../lyric/infra/models/lyric_model.dart';
import '../../lyric/presentation/blocs/lyric_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final LyricBloc _bloc;
  int selectedIndex = 0;
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();
    /*pageViewController.addListener(() {
      setState(() {
        selectedIndex = pageViewController.page!.toInt();
      });
    });*/
    //_bloc = LyricBloc(getLyrics: getLyrics);
    // _bloc.add(GetLyricsEvent());
  }

  @override
  void dispose() {
    //_bloc.close();
    super.dispose();
    pageViewController.dispose();
  }

  void onItemTapped(int index) {
    selectedIndex = index;
    pageViewController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: PageView(
          controller: pageViewController,
          children: [
            Container(
              decoration: const BoxDecoration(color: AppColors.white),
              child: const Text("Home"),
            ),
            const LyricsListView(),
            Container(
              decoration: const BoxDecoration(color: AppColors.white),
              child: const Text("Dizimos"),
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedBuilder(
        animation: pageViewController,
        builder: (context, child) {
          return Platform.isIOS
              ? cupertinoBottomNavBar()
              : materialBottomNavBar();
        },
      ),
    );
  }

  Widget cupertinoBottomNavBar() {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: selectedIndex,activeColor: AppColors.darkGreen,
        backgroundColor: AppColors.white,
        items: [
          BottomNavigationBarItem(
            icon: selectedIndex == 0
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
            icon: selectedIndex == 1
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
            icon: selectedIndex == 2
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
                        //Navigator.pushNamed(context, 'p2');
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

  Widget materialBottomNavBar() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(24), topLeft: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              offset: const Offset(1, 2),
              spreadRadius: 3,
              blurRadius: 7,
              blurStyle: BlurStyle.outer),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        child: BottomNavigationBar(
          selectedFontSize: 12,elevation: 10,
          currentIndex: selectedIndex,
          unselectedLabelStyle: AppFonts.selectedBottomNav,
          selectedLabelStyle: AppFonts.selectedBottomNav,
          selectedItemColor: AppColors.darkGreen,
          unselectedItemColor: AppColors.grey,
          backgroundColor: AppColors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: selectedIndex == 0
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
              icon: selectedIndex == 1
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
              icon: selectedIndex == 2
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
          onTap: onItemTapped,
        ),
      ),
    );
  }
}
