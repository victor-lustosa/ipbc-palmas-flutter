import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.darkGreen,
          title: const Text(
            'Igreja Presbiteriana Central de Palmas',
            style: TextStyle(color: AppColors.white, fontSize: 17),
          )),
      body: const Center(child: Text('Site Oficial')),
    );
  }
}
