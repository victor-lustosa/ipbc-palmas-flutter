import 'package:flutter/material.dart';

import '../../shared/layout/top_bar/top_bar_widget.dart';
import '../components/about_church_widget.dart';
import '../components/about_services_widget.dart';
import '../components/app_stores_widget.dart';
import '../components/contact_form_widget.dart';
import '../components/location_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TopBarWidget(),
              AboutChurchWidget(),
              LocationWidget(),
              AboutServicesWidget(),
              AppStoresWidget(),
              ContactFormWidget()
            ],
          ),
        ),
      ),
    );
  }
}
