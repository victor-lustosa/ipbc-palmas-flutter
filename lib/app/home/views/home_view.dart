import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view-models/home_view_model.dart';
import '../../lyric/lyric_module.dart';
import '../../offers/views/offers_view.dart';
import '../../lyric/presentation/views/lyrics_list_view.dart';
import '../../configs/app_routes.dart';
import '../../shared/layout/bottom-bar/cupertino/cupertino_bottom_bar_widget.dart';
import '../../shared/layout/bottom-bar/material/material_bottom_bar_widget.dart';
import '../../configs/app_configs.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewModel _homeViewModel;
  int selectedIndex = 0;
  final pageViewController = PageController();
  @override
  void initState() {
    super.initState();
    _homeViewModel = context.read<HomeViewModel>();
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  void onItemTapped(int index) {
    selectedIndex = index;
    pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutQuint,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [...lyricModule],
      child: WillPopScope(
        onWillPop: Platform.isIOS
            ? null
            : _homeViewModel.systemBackButtonPressed,
        child: Scaffold(
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
                OffersView(),
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
        ),
      ),
    );
  }
}
