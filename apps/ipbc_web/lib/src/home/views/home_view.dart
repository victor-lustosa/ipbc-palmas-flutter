import 'package:flutter/material.dart';
import 'package:ipbc_web/src/home/components/location_widget.dart';

import '../../shared/layout/top_bar/top_bar_widget.dart';
import '../components/about_church_widget.dart';
import '../components/about_services_widget.dart';

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
              AboutServicesWidget()
            ],
          ),
        ),
      ),
    );
  }
}
