import 'package:core_module/core_module.dart' ;
import 'package:flutter/material.dart';
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

}