import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import '../lyric/lyric_module.dart';

import '../service/service_module.dart';
import '../service/views/service_view.dart';
import '../service/views/services_collection_view.dart';
import '../service/views/services_list_view.dart';
import 'view-models/home_view_model.dart';
import 'views/home_view.dart';
import 'views/init_view.dart';

class HomeModule extends Module {
  static const String initialRoute = '/';
  static const String homeRoute = '/home';
  static const String serviceRoute = '/service';
  static const String servicesListRoute = '/services';
  static const String servicesCollectionRoute = '/services-collection';

  static final GlobalKey<NavigatorState> _androidNavigatorKey =
  GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> getAndroidNavigatorKey() {
    return _androidNavigatorKey;
  }
  @override
  void binds(Injector i) {
    i.add(HomeViewModel.new);
  }

  @override
  List<Module> get imports => [LyricModule(), ServiceModule()];

  @override
  void routes(r) {
    r.child(initialRoute, child: (_) => const InitView());
  }
}
