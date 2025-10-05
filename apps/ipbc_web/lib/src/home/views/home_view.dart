import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../../layout/footer/footer_widget.dart';
import '../../../layout/top_bar/top_bar_widget.dart';
import '../components/about_church_widget.dart';
import '../components/about_services_widget.dart';
import '../components/app_stores_widget.dart';
import '../components/contact_form_widget.dart';
import '../components/location_widget.dart';
import '../view_models/home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late final AnimationController _shimmerController;

  @override
  initState() {
    super.initState();
    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1200));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: Modular.get<HomeViewModel>().scrollController,
          child: Column(
            children: [
              const TopBarWidget(),
              AboutChurchWidget(shimmerController: _shimmerController),
              const LocationWidget(),
              AboutServicesWidget(shimmerController: _shimmerController),
              const AppStoresWidget(),
              const ContactFormWidget(),
              const FooterWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
