import 'dart:io';
import 'package:flutter/material.dart';
import '../view-models/home_view_model.dart';

import '../../offering/views/offering_view.dart';
import '../../lyric/presentation/views/lyrics_list_view.dart';
import '../../shared/configs/app_routes.dart';
import '../../shared/layout/bottom-bar/cupertino/cupertino_bottom_bar_widget.dart';
import '../../shared/layout/bottom-bar/material/material_bottom_bar_widget.dart';
import '../../shared/configs/app_configs.dart';
import 'package:provider/provider.dart';

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
    _homeViewModel.addListener(() {
      setState(() {
        pageViewController.animateToPage(_homeViewModel.selectedIndex,
            duration: const Duration(milliseconds: 500), curve: Curves.bounceOut);
      });
    });
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
      duration: const Duration(milliseconds: 1400),
      curve: Curves.bounceOut,
    );
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
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
                  _homeViewModel.selectedIndex = index;
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
      ),
    );
  }
}
