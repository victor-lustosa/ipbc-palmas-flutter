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
    i.addSingleton<SupabaseClient>(() => Supabase.instance.client);
    i.addSingleton<SupabaseDatasource>(
      () => SupabaseDatasource(
        supabaseClient: i.get<SupabaseClient>(),
      ),
    );
    i.addSingleton<Repository<List>>(
      () => Repository<List>(
        datasource: i.get<SupabaseDatasource>(),
      ),
    );
  }
}
