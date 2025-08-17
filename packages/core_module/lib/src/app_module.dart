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
    i.addLazySingleton<EditLyricStore>(EditLyricStore.new);
    i.addLazySingleton<LyricsListStore>(LyricsListStore.new);
    i.addSingleton<SupabaseClient>(() => Supabase.instance.client);
    i.addSingleton<SupabaseRepository>(
      () => SupabaseRepository(supabaseClient: i.get<SupabaseClient>()),
    );
    i.addLazySingleton(
      () => AuthCircleAvatarStore(offlineUse: i.get<IOfflineAuthUseCases>()),
    );
    i.addSingleton<Isar>(() => Isar.getInstance());
    i.addSingleton<IsarRepository>(() => IsarRepository(isar: i.get<Isar>()));
    i.addSingleton(
      () =>
          UseCases<SupabaseRepository>(repository: i.get<SupabaseRepository>()),
    );
    i.addSingleton(() => MainTopBarStore());
    i.addSingleton(() => AppGlobalKeys());
    i.addSingleton<IOfflineAuthUseCases>(
      () => OfflineAuthUseCases(repository: i.get<IsarRepository>()),
    );

    i.addSingleton(
      () => UseCases<IsarRepository>(repository: i.get<IsarRepository>()),
    );
    i.addLazySingleton<EditLiturgyStore>(EditLiturgyStore.new);
    i.addLazySingleton<SearchLyricsStore>(SearchLyricsStore.new);
    i.addLazySingleton<ServicesPreviewStore>(ServicesPreviewStore.new);
    i.addLazySingleton<SlideCardsStore>(SlideCardsStore.new);
  }
}
