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
    i.addSingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
    i.addSingleton<FirestoreDatasource>(
      () => FirestoreDatasource(
        firestore: i.get<FirebaseFirestore>(),
      ),
    );
    i.addSingleton<Repository<Stream<List<Map>>>>(
      () => Repository<Stream<List<Map>>>(
        datasource: i.get<FirestoreDatasource>(),
      ),
    );
  }
}
