
import 'package:lyric_module/lyric_module.dart';
import '../home/home_module.dart';
import 'views/init_view.dart';

class InitModule extends Module {
  static const String initialRoute = '/init/';

  @override
  List<Module> get imports => [
        HomeModule(),
        LyricModule(),
      ];

  @override
  void routes(r) {
    r.child('/', child: (_) => const InitView());
  }
}
