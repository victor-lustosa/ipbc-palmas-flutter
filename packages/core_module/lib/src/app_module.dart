import 'package:core_module/src/events/external/repositories/event_repository.dart';
import 'package:core_module/src/events/infra/use_cases/event_use_cases.dart';

import '../core_module.dart';
import 'auth/infra/use_cases/auth_use_cases.dart';

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
    i.addSingleton<SupabaseRepository>(
          () => SupabaseRepository(supabaseClient: i.get<SupabaseClient>()),
    );

    i.addLazySingleton<HiveRepository>(() =>
        HiveRepository(),
    );

    i.addSingleton(
          () =>
          UseCases<SupabaseRepository>(repository: i.get<SupabaseRepository>()),
    );

    i.addLazySingleton<LyricsListStore>(LyricsListStore.new);
    i.addLazySingleton<ManageLyricStore>(
          () =>
          ManageLyricStore(
            useCases: i.get<UseCases<SupabaseRepository>>(),
            lyricsListStore: i.get<LyricsListStore>(),
          ),
    );
    i.addLazySingleton<IAuthUseCases>(
          () =>
          AuthUseCases(
            offlineRepository: i.get<HiveRepository>(),
            onlineRepository: SupaAuthRepository(
              supaClient: i.get<SupabaseClient>(),
            ),
          ),
    );
    i.addLazySingleton(
          () => AuthCircleAvatarStore(authUseCase: i.get<IAuthUseCases>()),
    );

    i.addLazySingleton<IEventRepository>(EventRepository.new);
    i.addLazySingleton(
          () => EventUseCases(repository: i.get<IEventRepository>()),
    );
    i.addLazySingleton(
          () =>
          CreateEventStore(
            useCases: i.get<UseCases<SupabaseRepository>>(),
            eventUseCases: i.get<EventUseCases>(),
          ),
    );

    i.addLazySingleton<ServiceStore>(
          () =>
          ServiceStore(
            manageLyricStore: i.get<ManageLyricStore>(),
            lyricsListStore: i.get<LyricsListStore>(),
            searchLyricsStore: i.get<SearchLyricsStore>(),
            manageServiceStore: i.get<ManageServiceStore>(),
          ),
    );
    i.addLazySingleton<ManageServiceStore>(
          () =>
          ManageServiceStore(useCases: i.get<UseCases<SupabaseRepository>>()),
    );
    i.addLazySingleton<SearchLyricsStore>(
          () => SearchLyricsStore(manageLyricStore: i.get<ManageLyricStore>()),
    );
    i.addLazySingleton<SlideCardsStore>(SlideCardsStore.new);
  }
}
