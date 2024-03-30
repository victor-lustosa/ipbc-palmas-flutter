import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:service_module/src/ui/views/admin/search_lyrics_view.dart';
import 'package:service_module/src/ui/views/admin/services_preview_view.dart';
import 'ui/blocs/services_collection_bloc.dart';

class ServiceModule extends Module {
  static const String serviceRoute = '/service';
  static const String editLiturgiesRoute = "/edit-liturgies";
  static const String servicesPreviewRoute = "/services-preview";
  static const String searchLyricsRoute = "/search-lyrics";
  static const String servicesCollectionRoute = "/services-collection";
  static const String servicesListRoute = '/services-list';
  static const String servicesRoute = '/services';

  @override
  void binds(i) {
    i.addLazySingleton<ServicesCollectionBloc>(
      () => ServicesCollectionBloc(
        supaUseCases: i.get<ServicesUseCases>(),
      ),
      config: CoreModule.blocConfig(),
    );
  }

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(r) {
    r.child(
      editLiturgiesRoute,
      transition: TransitionType.custom,
      child: (_) => EditLiturgiesView(dto: r.args.data as EditLiturgiesDTO),
      customTransition: CustomTransition(
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: anim1.drive(
              Tween(begin: const Offset(1, 0), end: Offset.zero).chain(
                CurveTween(curve: Curves.ease),
              ),
            ),
            child: child,
          );
        },
      ),
    );
    r.child(
      servicesPreviewRoute,
      transition: TransitionType.custom,
      child: (_) => ServicesPreviewView(dto: r.args.data as ServicesPreviewDTO),
      customTransition: CustomTransition(
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: anim1.drive(
              Tween(begin: const Offset(1, 0), end: Offset.zero).chain(
                CurveTween(curve: Curves.ease),
              ),
            ),
            child: child,
          );
        },
      ),
    );
    r.child(
      searchLyricsRoute,
      transition: TransitionType.custom,
      child: (_) => SearchLyricsView(dto: r.args.data as EditLiturgiesDTO),
      customTransition: CustomTransition(
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: anim1.drive(
              Tween(begin: const Offset(1, 0), end: Offset.zero).chain(
                CurveTween(curve: Curves.ease),
              ),
            ),
            child: child,
          );
        },
      ),
    );
  }
}
