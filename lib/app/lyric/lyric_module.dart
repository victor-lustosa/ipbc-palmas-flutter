import 'package:provider/provider.dart';

import '../lyric/infra/models/hive-dtos/hive_services_collection_dto.dart';
import '../lyric/infra/use-cases/collections_use_cases.dart';
import '../lyric/presentation/blocs/services_collection_bloc.dart';
import '../lyric/presentation/view-models/lyrics_view_model.dart';
import '../core/external/firestore_datasource.dart';
import '../core/infra/repositories/repository.dart';
import '../core/external/hive_datasource.dart';
import 'infra/use-cases/lyrics_use_cases.dart';
import 'infra/use-cases/services_use_cases.dart';
import 'infra/models/hive-dtos/hive_lyric_dto.dart';
import 'infra/models/hive-dtos/hive_service_dto.dart';
import 'presentation/blocs/lyric_bloc.dart';
import 'presentation/blocs/service_bloc.dart';

final lyricModule = [
  Provider<LyricsViewModel>(
    create: (_) => LyricsViewModel(),
  ),
  Provider<Repository<Stream<List<Map>>>>(
    create: (context) => Repository<Stream<List<Map>>>(
        datasource: context.read<FirestoreDatasource>(),
    ),
  ),
  Provider<ServicesCollectionBloc>(
    create: (context) => ServicesCollectionBloc(
      fireCollectionUseCases: CollectionsUseCases(
        repository: context.read<Repository<Stream<List<Map>>>>(),
      ),
      hiveCollectionUseCases: CollectionsUseCases(
        repository: Repository(
          datasource: HiveDatasource<HiveServicesCollectionDTO>(boxLabel: 'services-collection'),
        ),
      ), lyricsViewModel: context.read<LyricsViewModel>(),
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
    ),
  ),
  Provider<ServiceBloc>(
    create: (context) => ServiceBloc(
      fireServicesUseCases: ServicesUseCases(
        repository: context.read<Repository<Stream<List<Map>>>>(),
      ),
      hiveServicesUseCases: ServicesUseCases(
        repository: Repository(
          datasource: HiveDatasource<HiveServiceDTO>(boxLabel: 'services'),
        ),
      ),lyricsViewModel: context.read<LyricsViewModel>(),
    ),
  ),

];
