import 'package:core_module/core_module.dart';

import '../splash/main_module.dart';
import 'views/lyric_view.dart';
import 'views/lyrics_list_view.dart';
import 'views/service_view.dart';
import 'views/services_collection_view.dart';
import 'view-models/lyrics_view_model.dart';
import 'views/services_list_view.dart';

import 'blocs/services_list_bloc.dart';
import 'blocs/lyric_bloc.dart';
import 'blocs/services_collection_bloc.dart';

class LyricModule extends Module {

  static const String initialRoute = "/";
  static const String insertLyricsRoute = "/insert-lyrics";
  static const String serviceRoute = "/service";
  static const String lyricsListRoute = "/lyrics-list";
  static const String lyricRoute = "/lyric";
  static const String servicesCollectionRoute = "/services-collection";

  @override
  void binds(i) {
    i.addSingleton<LyricsViewModel>(() => LyricsViewModel(analyticsUtil: i.get<AnalyticsUtil>()));
    i.addSingleton<ServicesCollectionBloc>(() => ServicesCollectionBloc(
        fireUseCases: ServiceUseCases(
          repository: i.get<Repository<Stream<List<Map>>>>(),
        ),
        hiveUseCases: ServiceUseCases(
          repository: Repository(
            datasource: HiveDatasource<HiveCollectionDTO>(boxLabel: 'collection'),
          ),
        ),
        lyricsViewModel: i.get<LyricsViewModel>(),
        analyticsUtil: i.get<AnalyticsUtil>(),
      ),
      config: CoreModule.blocConfig(),
    );

    i.addSingleton<LyricBloc>(() => LyricBloc(
        fireLyricsUseCase: LyricsUseCases(
          repository: i.get<Repository<Stream<List<Map>>>>(),
        ),
        hiveLyricsUseCase: LyricsUseCases(
          repository: Repository(
            datasource: HiveDatasource<HiveLyricDTO>(boxLabel: 'lyrics'),
          ),
        ),
        lyricsViewModel: i.get<LyricsViewModel>(),
        analyticsUtil: i.get<AnalyticsUtil>(),
      ),
      config: CoreModule.blocConfig(),
    );

    i.addSingleton<ServicesListBloc>(() => ServicesListBloc(
        fireUseCases: ServicesUseCases(
          repository: i.get<Repository<Stream<List<Map>>>>(),
        ),
        hiveUseCases: ServicesUseCases(
          repository: Repository(
            datasource: HiveDatasource<HiveServicesDTO>(boxLabel: 'services'),
          ),
        ),
        lyricsViewModel: i.get<LyricsViewModel>(),
        analyticsUtil: i.get<AnalyticsUtil>(),
      ),
      config: CoreModule.blocConfig(),
    );
  }

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(r) {
    r.child(initialRoute, child: (_)=> const ServicesListView());
    r.child(lyricRoute, child: (_) => LyricView(lyricEntity: Modular.args as LyricEntity));
    r.child(lyricsListRoute, child: (_) => const LyricsListView());
    r.child(serviceRoute, child: (_) => ServiceView(entity: Modular.args as ServiceViewDTO));
    r.child(servicesCollectionRoute, child: (_) => ServicesCollectionView(servicesCollection: Modular.args as ServicesEntity));
  }
}
