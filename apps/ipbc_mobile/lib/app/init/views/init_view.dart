import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../offers/views/offers_view.dart';
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
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOutQuint,
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


