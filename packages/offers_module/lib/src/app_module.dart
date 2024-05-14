import 'package:core_module/core_module.dart';
import 'ui/controller/banner_controller.dart';

class OffersModule extends Module {
  static const String offersRoute = '/';

  @override
  void binds(Injector i) {
    i.addLazySingleton<BannerController>(BannerController.new);
  }

}
