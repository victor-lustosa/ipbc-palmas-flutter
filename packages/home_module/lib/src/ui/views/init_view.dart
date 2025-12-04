// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:offers_module/offers_module.dart';

import '../../../home_module.dart';
import '../native_home_routes.dart';

class InitView extends StatefulWidget {
  const InitView({super.key});

  @override
  State<InitView> createState() => _InitViewState();
}

class _InitViewState extends State<InitView> {
  late final AppLinksUtil appLinks;
  int selectedIndex = 0;

  final _controller = PageController();
  @override
  void initState() {
    super.initState();
    appLinks = Modular.get<AppLinksUtil>();

    /// Deep link ao abrir o app
    appLinks.getInitialLink().then((link) {
      if (link != null) {
        _handleDeepLink(link);
      }
    });

    /// Deep link enquanto o app está aberto
    appLinks.linkStream.listen((link) {
      _handleDeepLink(link);
    });
  }

  void _handleDeepLink(String link) {
    print("🔗 Deep Link recebido: $link");

    // Exemplo de link: https://meusite.com/evento/123
    Uri uri = Uri.parse(link);

    if (uri.pathSegments.contains("evento")) {
      String id = uri.pathSegments.last;

      // Exemplo de navegação
      Navigator.pushNamed(context, '/eventDetails', arguments: id);
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
