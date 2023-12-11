import 'package:core_module/core_module.dart';
import '../home/views/home_view.dart';
import 'view_models/home_view_model.dart';

class MainModule extends Module {

  @override
  void binds(i) {
    i.addSingleton<HomeViewModel>(HomeViewModel.new);
  }

  @override
  void routes(r) {
    r.child('/home', child: (_) => const HomeView());
    r.module('/', module: AuthModule());
  }
}
