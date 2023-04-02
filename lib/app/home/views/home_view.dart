import 'dart:io';
import 'package:flutter/material.dart';

import '../../offering/views/offering_view.dart';
import '../../lyric/presentation/views/lyrics_list_view.dart';
import '../../shared/configs/app_routes.dart';
import '../../shared/layout/bottom-bar/cupertino/cupertino_bottom_bar_widget.dart';
import '../../shared/layout/bottom-bar/material/material_bottom_bar_widget.dart';
import '../../shared/configs/app_configs.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  int selectedIndex = 0;
  final pageViewController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
          onPageChanged: (index) {
            setState(
              () {
                selectedIndex = index;
              },
            );
          },
          children: const [
            ServicesListRoutes(),
            LyricsListView(),
            OfferingView(),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedBuilder(
        animation: pageViewController,
        builder: (__, _) {
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
