import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'src/home/views/home_view.dart';
import 'src/home/view_models/home_view_model.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy());
  runApp(
    ModularApp(
      module: MainModule(),
      child: MaterialApp.router(
        title: 'Presbiteriana Central Palmas',
        theme: lightTheme,
        routerConfig: Modular.routerConfig,
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class MainModule extends Module {

  @override
  void binds(i) {
    i.addSingleton<HomeViewModel>(HomeViewModel.new);
  }

  @override
  void routes(r) {
    r.child('/home', child: (_) => const HomeView());
    r.child('/', child: (_) => const HomeView());
    // r.module('/', module: AuthModule());
  }
}