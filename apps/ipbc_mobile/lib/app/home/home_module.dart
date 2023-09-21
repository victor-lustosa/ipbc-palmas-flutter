import 'package:core_module/core_module.dart';
import 'package:ipbc_palmas/app/home/views/home_view.dart';
import 'package:ipbc_palmas/app/home/views/init_view.dart';
import '../lyric/lyric_module.dart';

import '../service/service_module.dart';
import '../service/views/service_view.dart';
import '../service/views/services_collection_view.dart';
import '../service/views/services_list_view.dart';
import 'view-models/home_view_model.dart';

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
    r.child(
      initialRoute,
      child: (_) => const InitView(),
      children: [
        ChildRoute(
          homeRoute,
          child: (_) => const HomeView(),
        ),
        ChildRoute(
          servicesListRoute,
          child: (_) => const ServicesListView(),
        ),
        ChildRoute(
          servicesCollectionRoute,
          child: (_) => ServicesCollectionView(
            entity: r.args.data as ServicesEntity,
          ),
        ),
        ChildRoute(
          serviceRoute,
          child: (_) => ServiceView(
            entity: r.args.data as ServiceViewDTO,
          ),
        ),
      ],
    );
    r.module(lyricsRoute, module: LyricModule());
  }
}
