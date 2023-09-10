import 'package:core_module/core_module.dart';
import '../lyric/lyric_module.dart';

import 'view-models/home_view_model.dart';

class HomeModule extends Module{
 @override
  void binds(Injector i) {
   i.add(HomeViewModel.new);
  }
  @override
  void routes(r) {
   r.module('/lyrics', module: LyricModule());
  }
}