//import 'dart:io';

import 'package:flutter/cupertino.dart' hide CupertinoTabBar, CupertinoTabScaffold;
import '../../core/layout/top-bar/top_bar_widget.dart';
import 'package:flutter/material.dart';
import '../../shared/configs/app_configs.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import '../../lyric/presentation/blocs/lyric_bloc.dart';
import '../../shared/components/carousel/carousel_widget.dart';
import '../../shared/configs/app_routes.dart';

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
        child: Column(
          children: [
            const TopBarWidget(),
            Padding(
              padding: const EdgeInsets.only(
                top: 28,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 17.0,
                      top: 2,
                    ),
                    child: Text(
                      "Músicas",
                      style: AppFonts.headHome,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10.0,
                      right: 0,
                    ),
                    child: SizedBox(
                      height: 30,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.lyricRoute,
                          );
                        },
                        icon: const Icon(
                          size: 32,
                          Icons.navigate_next_sharp,
                          color: AppColors.darkGreen,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 18.0,
                top: 3,
              ),
              child: Text(
                "Acompanhe as letras das músicas cantadas no culto.",
                style: AppFonts.subHeadHome,
              ),
            ),
            Carousel(images: [AppImages.manha, AppImages.noite],)
          ],
        ),
      ),
      extendBody: true,
    );
  }
}
