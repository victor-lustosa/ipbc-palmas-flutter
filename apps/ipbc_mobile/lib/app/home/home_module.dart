import 'package:core_module/core_module.dart';

import '../offers/controller/banner_controller.dart';

import 'blocs/home_bloc.dart';
import 'views/init_view.dart';

class HomeModule extends Module {
  static const String initialRoute = '/';

  @override
  List<Module> get imports => [
        LyricModule(),
        ServiceModule(),
      ];

  @override
  void binds(Injector i) {
    i.addSingleton(
      () => ServicesUseCases(
        repository: i.get<Repository<List<dynamic>>>(),
      ),
    );
    i.addLazySingleton<HomeBloc>(
      () => HomeBloc(
        supaUseCases: i.get<ServicesUseCases>(),
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
