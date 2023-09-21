import 'package:core_module/core_module.dart';
import '../lyric/lyric_module.dart';

import '../service/service_module.dart';
import 'view-models/home_view_model.dart';
import 'views/init_view.dart';

class HomeModule extends Module {
  static const String initialRoute = '/';
  static const String homeRoute = '/home';
  static const String initRoute = '/init';
  static const String lyricsRoute = '/lyrics';
  static const String serviceRoute = '/service';
  static const String servicesListRoute = '/services';
  static const String servicesCollectionRoute = '/services-collection';

  @override
  void binds(Injector i) {
    i.add(HomeViewModel.new);
  }

  @override
  List<Module> get imports => [LyricModule(), ServiceModule()];

  @override
  void routes(r) {
    r.child(initialRoute, child: (_) => const InitView());
    r.module(lyricsRoute, module: LyricModule());
  }
}
