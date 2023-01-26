import 'dart:io';

import 'package:ipbc_palmas/app/lyric/presentation/views/offering_view.dart';
import 'package:ipbc_palmas/app/lyric/presentation/views/weekday_lyrics_list_view.dart';

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
  final pageViewController = PageController();

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
          children: [
            WeekdayLyricsListView(),
            const LyricsListView(),
            const OfferingView(),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedBuilder(
        animation: pageViewController,
        builder: (context, child) {
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
