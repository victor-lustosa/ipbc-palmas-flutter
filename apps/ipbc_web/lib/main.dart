import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'src/home/view_models/home_view_model.dart';
import 'src/home/views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    SupabaseRepository.init(),
    initializeDateFormatting('pt_BR', null),
  ]);
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
    i.addSingleton<SupabaseClient>(() => Supabase.instance.client);
    i.addSingleton<SupabaseRepository>(
      () => SupabaseRepository(supabaseClient: i.get<SupabaseClient>()),
    );
    i.addSingleton(
      () =>
          UseCases<SupabaseRepository>(repository: i.get<SupabaseRepository>()),
    );

    i.addSingleton<HomeViewModel>(
      () =>
          HomeViewModel(useCases: i.get<UseCases<SupabaseRepository>>()),
    );
  }

  @override
  void routes(r) {
    r.child('/home', child: (_) => const HomeView());
    r.child('/', child: (_) => const HomeView());
    // r.module('/', module: AuthModule());
  }
}
