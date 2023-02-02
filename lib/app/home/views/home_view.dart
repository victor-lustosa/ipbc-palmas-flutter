import 'dart:io';

import 'package:ipbc_palmas/app/home/views/weekend_lyrics_routers.dart';
import 'package:ipbc_palmas/app/lyric/presentation/views/offering_view.dart';
import '../../lyric/presentation/views/lyrics_list_view.dart';
import '../../shared/layout/bottom-bar/cupertino/cupertino_bottom_bar_widget.dart';
import '../../shared/layout/bottom-bar/material/material_bottom_bar_widget.dart';
import 'package:flutter/material.dart';
import '../../shared/configs/app_configs.dart';
//import '../../lyric/presentation/blocs/lyric_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //late final LyricBloc _bloc;
  int selectedIndex = 0;
  final pageViewController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
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
          children: const [
            WeekdendLyricsRouters(),
            LyricsListView(),
            OfferingView(),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedBuilder(
        animation: pageViewController,
        builder: (context, child) {
          switch (pageViewController.hasClients
              ? pageViewController.page?.toInt()
              : pageViewController.initialPage) {
            case 0:
              selectedIndex = 0;
              break;
            case 1:
              selectedIndex = 1;
              break;
            case 2:
              selectedIndex = 2;
              break;
            default:
              break;
          }
          return Platform.isIOS
              ? CupertinoBottomBarWidget(
                  selectedIndex: selectedIndex,
                  callback: (int index) {
                    setState(
                      () {
                        onItemTapped(index);
                      },
                    );
                  },
                )
              : MaterialBottomBarWidget(
                  selectedIndex: selectedIndex,
                  callback: (int index) {
                    setState(
                      () {
                        onItemTapped(index);
                      },
                    );
                  },
                );
        },
      ),
    );
  }
}
