import 'package:supabase_flutter/supabase_flutter.dart';

import '../core_module.dart';

class CoreModule extends Module {
  static BindConfig<T> blocConfig<T extends Bloc>() {
    return BindConfig(
      notifier: (bloc) => bloc.stream,
      onDispose: (bloc) => bloc.close(),
    );
  }

  @override
  void exportedBinds(Injector i) {
     i.addSingleton<SupabaseDatasource>(() => SupabaseDatasource(supabaseClient: Supabase.instance.client));
    i.addSingleton<Repository<List<Map>>>(
          () => Repository<List<Map>>(
        datasource: i.get<SupabaseDatasource>(),
      ),
    );
  }
}
