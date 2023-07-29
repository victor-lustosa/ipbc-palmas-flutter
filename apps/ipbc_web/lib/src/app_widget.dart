
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'home/views/home_view.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'IPBC Palmas',
        theme: lightTheme,
        home: const HomeView(),
        debugShowCheckedModeBanner: false,
    );
  }
}