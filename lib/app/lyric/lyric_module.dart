import 'package:provider/provider.dart';

import 'presentation/blocs/lyric_bloc.dart';
import 'infra/use-cases/lyrics_use_cases.dart';
import 'infra/use-cases/collection_use_cases.dart';
import 'infra/models/hive-dtos/hive_lyric_dto.dart';
import 'infra/models/hive-dtos/hive_collection_dto.dart';
import 'presentation/blocs/services_collection_bloc.dart';
import '../core/external/hive_datasource.dart';
import '../core/external/firestore_datasource.dart';
import '../core/infra/repositories/repository.dart';
import '../shared/components/utils/analytics_util.dart';
import '../lyric/infra/use-cases/services_use_cases.dart';
import '../lyric/presentation/blocs/services_list_bloc.dart';
import '../lyric/infra/models/hive-dtos/hive_services_dto.dart';
import '../lyric/presentation/view-models/lyrics_view_model.dart';

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
      fireUseCases: CollectionUseCases(
        repository: context.read<Repository<Stream<List<Map>>>>(),
      ),
      hiveUseCases: CollectionUseCases(
        repository: Repository(
          datasource: HiveDatasource<HiveCollectionDTO>(boxLabel: 'collection'),
        ),
      ),lyricsViewModel: context.read<LyricsViewModel>(),
        analyticsUtil: context.read<AnalyticsUtil>(),
    ),
  ),
];
