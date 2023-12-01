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
    i.addSingleton<AnalyticsUtil>(AnalyticsUtil.new);
     i.addSingleton<SupabaseDatasource>(SupabaseDatasource.new);
    i.addSingleton<Repository<List<Map>>>(
          () => Repository<List<Map>>(
        datasource: i.get<SupabaseDatasource>(),
      ),
    );
  }
}
