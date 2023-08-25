import 'package:core_module/core_module.dart';
import 'blocs/lyric_bloc.dart';
import 'blocs/services_collection_bloc.dart';
import '../lyric/blocs/services_list_bloc.dart';
import '../lyric/view-models/lyrics_view_model.dart';

final lyricModule = [

  Provider<LyricsViewModel>(
    create: (context) => LyricsViewModel(
        analyticsUtil: context.read<AnalyticsUtil>(),
    ),
  ),
  Provider<Repository<Stream<List<Map>>>>(
    create: (context) => Repository<Stream<List<Map>>>(
        datasource: context.read<FirestoreDatasource>(),
    ),
  ),
  Provider<ServicesListBloc>(
    create: (context) => ServicesListBloc(
      fireUseCases: ServicesUseCases(
        repository: context.read<Repository<Stream<List<Map>>>>(),
      ),
      hiveUseCases: ServicesUseCases(
        repository: Repository(
          datasource: HiveDatasource<HiveServicesDTO>(boxLabel: 'services'),
        ),
      ), lyricsViewModel: context.read<LyricsViewModel>(),
      analyticsUtil: context.read<AnalyticsUtil>(),
    ),
  ),
  Provider<LyricBloc>(
    create: (context) => LyricBloc(
      fireLyricsUseCase: LyricsUseCases(
        repository: context.read<Repository<Stream<List<Map>>>>(),
      ),
      hiveLyricsUseCase: LyricsUseCases(
        repository: Repository(
          datasource: HiveDatasource<HiveLyricDTO>(boxLabel: 'lyrics'),
        ),
      ),lyricsViewModel: context.read<LyricsViewModel>(),
        analyticsUtil: context.read<AnalyticsUtil>(),
    ),
  ),
  Provider<ServicesCollectionBloc>(
    create: (context) => ServicesCollectionBloc(
      fireUseCases: ServiceUseCases(
        repository: context.read<Repository<Stream<List<Map>>>>(),
      ),
      hiveUseCases: ServiceUseCases(
        repository: Repository(
          datasource: HiveDatasource<HiveCollectionDTO>(boxLabel: 'collection'),
        ),
      ),lyricsViewModel: context.read<LyricsViewModel>(),
        analyticsUtil: context.read<AnalyticsUtil>(),
    ),
  ),
];
