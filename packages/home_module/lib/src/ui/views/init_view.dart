// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:offers_module/offers_module.dart';

import '../../../home_module.dart';
import '../blocs/home_bloc.dart';
import '../native_home_routes.dart';

class InitView extends StatefulWidget {
  const InitView({super.key});

  @override
  State<InitView> createState() => _InitViewState();
}

class _InitViewState extends State<InitView> {
  late final AppLinksUtil appLinks;
  late final HomeBloc _homeBloc;
  int selectedIndex = 0;
  final _controller = PageController();
  @override
  void initState() {
    super.initState();
    _homeBloc = Modular.get<HomeBloc>();
    appLinks = Modular.get<AppLinksUtil>();

    appLinks.getInitialLink().then((link) {
      if (link != null) {
        _handleDeepLink(link);
      }
    });

    appLinks.linkStream.listen((link) {
      _handleDeepLink(link);
    });
  }

  void _handleDeepLink(String link) {
    Uri uri = Uri.parse(link);

    if (uri.path.contains(AppRoutes.eventRoute)) {
      String id = uri.pathSegments.last;
      _homeBloc.add(DeepLinkDetailEvent(context: context, id: int.parse(id)));
    }
  }

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
      body: PageView(
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        children: const [NativeHomeRoutes(), NativeLyricRoutes(), OffersView()],
      ),
      bottomNavigationBar: MaterialBottomBarWidget(
        selectedIndex: selectedIndex,
        callback: (int index) {
          _onItemTapped(index);
        },
      ),
    );
  }
}
