
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../offers/views/offers_view.dart';
import '../home_module.dart';

class InitView extends StatefulWidget {
  const InitView({super.key});

  @override
  State<InitView> createState() => _InitViewState();
}

class _InitViewState extends State<InitView> {
  //pra vincular o botao de atualizar da tela de sem conexao com a tela correta
  //late final HomeViewModel _viewModel;
  int selectedIndex = 0;
  final _controller = PageController();

  @override
  void initState() {
    super.initState();
    // _viewModel = HomeViewModel();
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
          return MaterialBottomBarWidget(
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
