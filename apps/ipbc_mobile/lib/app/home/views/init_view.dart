import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../layout/bottom-bar/cupertino/cupertino_bottom_bar_widget.dart';
import '../../../layout/bottom-bar/material/material_bottom_bar_widget.dart';
import '../../configs/app_routes.dart';
import '../home_module.dart';
import '../view-models/home_view_model.dart';
import '../../offers/views/offers_view.dart';
import '../../lyric/views/lyrics_list_view.dart';

class InitView extends StatefulWidget {
  const InitView({super.key});

  @override
  State<InitView> createState() => _InitViewState();
}

class _InitViewState extends State<InitView> {
  late final HomeViewModel _viewModel;
  int selectedIndex = 0;
  final _controller = PageController();

  @override
  void initState() {
    super.initState();
    _viewModel = HomeViewModel();
  }

  void onItemTapped(int index) {
    selectedIndex = index;
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOutQuint,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        GlobalKey<NavigatorState> navigatorKey = AppRoutes.getAndroidNavigatorKey();
        if (navigatorKey.currentState != null && navigatorKey.currentState!.canPop()) {
          navigatorKey.currentState?.pop(navigatorKey.currentContext);
        } else {
          SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
        }
      },
      child: Scaffold(
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
              HomeRoutes(),
              LyricsListView(),
              OffersView(),
            ],
          ),
        ),
        extendBody: true,
        bottomNavigationBar: AnimatedBuilder(
          animation: _controller,
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
