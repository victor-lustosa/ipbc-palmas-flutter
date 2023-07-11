import 'package:flutter/material.dart';
import 'package:ipbc_web/src/shared/layout/top_bar/top_bar_widget.dart';

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
    return SafeArea(
      child: Scaffold(
        appBar: TopBarWidget(),
        body: SingleChildScrollView(
            child: Column(
              children: [
                const Center(child: Text('Site Oficial')),
                Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,)
              ],
            )),
      ),
    );
  }
}
