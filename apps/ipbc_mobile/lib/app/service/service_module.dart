import 'package:core_module/core_module.dart' ;
import 'package:flutter/material.dart';

import '../shared/view-models/services_view_model.dart';
import 'blocs/services_list_bloc.dart';
import 'blocs/services_collection_bloc.dart';
import 'views/admin/insert_services_view.dart';

class ServiceModule extends Module {

  static const String insertServicesRoute = "/insert-services";
  static const String serviceRoute = "/service";
  static const String servicesCollectionRoute = "/services-collection";

  @override
  void binds(i) {
    i.addLazySingleton<ServicesViewModel>(
      () => ServicesViewModel(
        analyticsUtil: i.get<AnalyticsUtil>(),
      ),
    );
    i.addLazySingleton<ServicesCollectionBloc>(
      () => ServicesCollectionBloc(
        supaUseCases: ServiceUseCases(
          repository: i.get<Repository<List<Map>>>(),
        ),
        viewModel: i.get<ServicesViewModel>(),
        analyticsUtil: i.get<AnalyticsUtil>(),
      ),
      config: CoreModule.blocConfig(),
    );

    i.addLazySingleton<ServicesListBloc>(
      () => ServicesListBloc(
        supaUseCases: ServicesUseCases(
          repository: i.get<Repository<List<Map>>>(),
        ),
        viewModel: i.get<ServicesViewModel>(),
        analyticsUtil: i.get<AnalyticsUtil>(),
      ),
      config: CoreModule.blocConfig(),
    );
  }

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(r) {
    r.child(
      insertServicesRoute,
      transition: TransitionType.custom,
      child: (_) => const InsertServicesView(),
      customTransition: CustomTransition(
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 500),
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position: anim1.drive(Tween(begin: const Offset(0, 1), end: Offset.zero).chain(CurveTween(curve: Curves.ease))),
            child: child,
          );
        },
      ),
    );
  }
}
