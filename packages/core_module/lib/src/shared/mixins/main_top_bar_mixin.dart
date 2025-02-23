
import '../../../core_module.dart';

mixin MainTopBarMixin {
   updateAuthAvatarKey() async {
     Modular.get<HomeBloc>().add(UpdateTopBarEvent());
  }
}
