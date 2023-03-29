
import '../core/external/firestore_datasource.dart';
import '../core/external/hive_datasource.dart';
import 'infra/models/hive-dtos/lyric_hive_dto.dart';
import 'infra/models/hive-dtos/hive_services_list_dto.dart';
import 'infra/use-cases/hive_lyrics_use_cases.dart';
import 'infra/use-cases/hive_services_use_cases.dart';
import 'presentation/blocs/lyric_bloc.dart';
import 'presentation/blocs/service_bloc.dart';
import 'infra/use-cases/fire_lyrics_use_cases.dart';
import 'infra/use-cases/fire_services_use_cases.dart';
import '../core/infra/repositories/repository.dart';
import 'package:provider/provider.dart';

final lyricModule = [

  Provider<Repository<Stream<List<Map>>>>(
    create: (context) => Repository<Stream<List<Map>>>(
        datasource: context.read<FirestoreDatasource>()
    ),
  ),

  Provider<LyricBloc>(
    create: (context) => LyricBloc(
      fireLyricsUseCase: FireLyricsUseCases(
        repository: context.read<Repository<Stream<List<Map>>>>(),
      ),
      hiveLyricsUseCase: HiveLyricsUseCases(
        repository: Repository<Stream<List<Map>>>(
          datasource: HiveDatasource<List<LyricHiveDTO>>(boxLabel: 'lyrics'),
        ),
      ),
    ),
  ),

  Provider<ServiceBloc>(
    create: (context) => ServiceBloc(
      fireServicesUseCases: FireServicesUseCases(
        repository: context.read<Repository<Stream<List<Map>>>>(),
      ),
      hiveServicesUseCases: HiveServicesUseCases(
        repository: Repository(
          datasource: HiveDatasource<HiveServicesListDTO>(boxLabel: 'services'),
        ),
      ),
    ),
  ),
];
