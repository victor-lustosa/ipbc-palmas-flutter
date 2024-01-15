import 'package:core_module/core_module.dart';

import '../offers/controller/banner_controller.dart';
import '../services/service_module.dart';
import '../lyrics/lyric_module.dart';

import 'blocs/home_bloc.dart';
import 'views/init_view.dart';

class HomeModule extends Module {
  static const String initialRoute = '/';
  static const String homeRoute = '/home';
  static const String serviceRoute = '/services';
  static const String servicesListRoute = '/services';
  static const String servicesCollectionRoute = '/services-collection';

  @override
  List<Module> get imports => [
        LyricModule(),
        ServiceModule(),
      ];
  @override
  void binds(Injector i) {
    i.addLazySingleton<HomeBloc>(
      () => HomeBloc(
        supaUseCases: ServicesUseCases(
          repository: i.get<Repository<List<dynamic>>>(),
        ),
      ),
      config: CoreModule.blocConfig(),
    );
    i.addLazySingleton<BannerController>(BannerController.new);
  }

  @override
  void routes(r) {
    r.child(initialRoute, child: (_) => const InitView());
  }
}
