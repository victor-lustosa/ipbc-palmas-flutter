
import 'package:flutter/material.dart';
import 'package:lyric_module/lyric_module.dart';
import 'package:offers_module/offers_module.dart';

import '../../home/home_module.dart';

class InitView extends StatefulWidget {
  const InitView({super.key});

  @override
  State<InitView> createState() => _InitViewState();
}

class _InitViewState extends State<InitView> {

  int selectedIndex = 0;

  final _controller = PageController();

  void _onItemTapped(int index) {
    selectedIndex = index;
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(
              () {
                selectedIndex = index;
              },
            );
          },
          children: const [
            NativeHomeRoutes(),
            NativeLyricRoutes(),
            OffersView(),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedBuilder(
        animation: _controller,
        builder: (__, _) {
          return MaterialBottomBarWidget(
            selectedIndex: selectedIndex,
            callback: (int index) {
              setState(
                () {
                  _onItemTapped(index);
                },
              );
            },
          );
        },
      ),
    );
  }
}


