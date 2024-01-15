
import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../layout/bottom-bar/material_bottom_bar_widget.dart';

import '../../services/views/admin/insert_services_view.dart';
import '../../services/views/services_collection_view.dart';
import '../../services/views/services_list_view.dart';
import '../../lyrics/views/lyrics_list_view.dart';
import '../../services/views/service_view.dart';
import '../../offers/views/offers_view.dart';
import '../../services/service_module.dart';
import '../../configs/app_routes.dart';

import '../views/home_view.dart';
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


class HomeRoutes extends StatefulWidget {
  const HomeRoutes({super.key});

  @override
  State<HomeRoutes> createState() => _HomeRoutesState();
}

class _HomeRoutesState extends State<HomeRoutes> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Platform.isIOS ? null : AppRoutes.getAndroidNavigatorKey(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case HomeModule.initialRoute:
            if (Platform.isIOS) {
              return CupertinoPageRoute(settings: settings, builder: (_) => const CupertinoPageScaffold(child: HomeView()));
            } else {
              return MaterialPageRoute(settings: settings, builder: (_) => const HomeView());
            }

          case HomeModule.servicesListRoute:
            return CustomTransitionPageRoute(
              transitionSpeed: const Duration(milliseconds: 700),
              reverseSpeed: const Duration(milliseconds: 700),
              child: ServicesListView(entitiesList: Modular.args.data ?? []),
              tween: Tween(begin: const Offset(1, 0), end: Offset.zero).chain(CurveTween(curve: Curves.ease)),
            );

          case ServiceModule.serviceRoute:
            return CustomTransitionPageRoute(
              transitionSpeed: const Duration(milliseconds: 700),
              reverseSpeed: const Duration(milliseconds: 700),
              child: ServiceView(entity: settings.arguments as ServiceViewDTO),
              tween: Tween(begin: const Offset(1, 0), end: Offset.zero).chain(CurveTween(curve: Curves.ease)),
            );

          case ServiceModule.servicesCollectionRoute:
            return CustomTransitionPageRoute(
              transitionSpeed: const Duration(milliseconds: 700),
              reverseSpeed: const Duration(milliseconds: 700),
              child: ServicesCollectionView(
                entity: settings.arguments as ServicesEntity,
              ),
              tween: Tween(begin: const Offset(1, 0), end: Offset.zero).chain(CurveTween(curve: Curves.ease)),
            );

          case ServiceModule.insertServicesRoute:
            return CustomTransitionPageRoute(
              transitionSpeed: const Duration(milliseconds: 700),
              reverseSpeed: const Duration(milliseconds: 700),
              child: const InsertServicesView(),
              tween: Tween(begin: const Offset(1, 0), end: Offset.zero).chain(CurveTween(curve: Curves.ease)),
            );

          default:
            return unknownRoute();
        }
      },
    );
  }
}
