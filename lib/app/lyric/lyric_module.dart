import '../core/external/firestore_datasource.dart';
import '../core/external/hive_datasource.dart';
import 'infra/models/hive-dtos/hive_lyrics_list_dto.dart';
import 'infra/models/hive-dtos/hive_services_list_dto.dart';
import 'presentation/blocs/lyric_bloc.dart';
import 'presentation/blocs/service_bloc.dart';
import 'infra/use-cases/lyrics_use_cases.dart';
import 'infra/use-cases/services_use_cases.dart';
import '../core/infra/repositories/repository.dart';
import 'package:provider/provider.dart';

final lyricModule = [
  Provider<Repository<Stream<List<Map>>>>(
    create: (context) => Repository<Stream<List<Map>>>(
        datasource: context.read<FirestoreDatasource>()),
  ),
  Provider<LyricBloc>(
    create: (context) => LyricBloc(
      fireLyricsUseCase: LyricsUseCases(
        repository: context.read<Repository<Stream<List<Map>>>>(),
      ),
      hiveLyricsUseCase: LyricsUseCases(
        repository: Repository(
          datasource: HiveDatasource<HiveLyricsListDTO>(boxLabel: 'lyrics'),
        ),
      ),
    ),
  ),
  Provider<ServiceBloc>(
    create: (context) => ServiceBloc(
      fireServicesUseCases: ServicesUseCases(
        repository: context.read<Repository<Stream<List<Map>>>>(),
      ),
      hiveServicesUseCases: ServicesUseCases(
        repository: Repository(
          datasource: HiveDatasource<HiveServicesListDTO>(boxLabel: 'services'),
        ),
      ),
    ),
  ),
];
