import 'package:core_module/core_module.dart';
import 'package:service_module/src/ui/stores/admin/edit_liturgy_view_model.dart';
import 'package:service_module/src/ui/stores/admin/edit_lyric_store.dart';
import 'package:service_module/src/ui/stores/admin/search_lyrics_store.dart';
import 'package:service_module/src/ui/views/admin/search_lyrics_view.dart';
import 'package:service_module/src/ui/views/admin/services_preview_view.dart';
import '../service_module.dart';
import 'ui/blocs/services_collection_bloc.dart';
import 'ui/views/admin/edit_lyric_view.dart';

class ServiceModule extends Module {

  @override
  void binds(i) {
    i.addLazySingleton<ServicesCollectionBloc>(
      () => ServicesCollectionBloc(
        onlineUseCases: i.get<UseCases<SupabaseRepository>>(),
      ),
      config: CoreModule.blocConfig(),
    );
    i.addLazySingleton<EditLyricStore>(EditLyricStore.new);
    i.addLazySingleton<SearchLyricsStore>(SearchLyricsStore.new);
    i.addSingleton<EditLiturgyViewModel>(EditLiturgyViewModel.new);
  }

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(r) {
    r.child(
      AppRoutes.editLyricRoute,
      transition: TransitionType.custom,
      child:
          (_) => EditLyricView(
            dto:
                r.args.data as EditLiturgyDTO? ??
                EditLiturgyDTO(
                  heading: '',
                  image:
                      'https://firebasestorage.googleapis.com/v0/b/ipbc-palmas-9d93d.appspot.com/o/service-covers%2Fh_saturday_evening.png?alt=media&token=bdfeec22-c201-4032-aa03-00c9d077e348',
                ),
          ),
      customTransition: ModularSlideTransition(),
    );
    r.child(
      AppRoutes.editLiturgiesRoute,
      transition: TransitionType.custom,
      child: (_) => EditLiturgyView(dto: r.args.data as EditLiturgyDTO),
      customTransition: ModularFadeTransition(),
    );
    r.child(
      AppRoutes.servicesPreviewRoute,
      transition: TransitionType.custom,
      child: (_) => ServicesPreviewView(dto: r.args.data as ServicesPreviewDTO),
      customTransition: ModularFadeTransition(),
    );
    r.child(
      AppRoutes.searchLyricsRoute,
      transition: TransitionType.custom,
      child: (_) => SearchLyricsView(dto: r.args.data as EditLiturgyDTO),
      customTransition: ModularFadeTransition(),
    );
  }
}
