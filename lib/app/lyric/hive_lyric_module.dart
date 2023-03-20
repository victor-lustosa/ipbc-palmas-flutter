
import 'presentation/blocs/lyric_bloc.dart';
import 'presentation/blocs/service_bloc.dart';
import '../shared/components/splash/infra/models/hive-dtos/lyric_hive_dto.dart';
import '../shared/components/splash/infra/models/hive-dtos/service_hive_dto.dart';

import '../core/external/hive_datasource.dart';
import '../core/infra/repositories/repository.dart';

import 'package:provider/provider.dart';

import 'infra/use-cases/lyrics_use_cases.dart';
import 'infra/use-cases/services_use_cases.dart';

final hiveLyricModule = [
  Provider<Repository<List<Map<dynamic, dynamic>>>>(
    create: (context) => Repository(
      datasource: HiveDatasource<LyricHiveDTO>(boxLabel: 'lyric'),
    ),
  ),

  Provider<Repository<List<Map<dynamic, dynamic>>>>(
    create: (context) => Repository(
      datasource: HiveDatasource<ServiceHiveDTO>(boxLabel: 'service'),
    ),
  ),
  Provider<LyricBloc>(
    create: (context) => LyricBloc(
      lyricsUseCase: LyricsUseCases(
        repository: context.read<Repository<Stream<List<Map<dynamic, dynamic>>>>>(),
      ),
    ),
  ),
  Provider<ServiceBloc>(
    create: (context) => ServiceBloc(
      servicesUseCases: ServicesUseCases(
        repository: context.read<Repository<Stream<List<Map<dynamic, dynamic>>>>>(),
      ),
    ),
  ),


];
