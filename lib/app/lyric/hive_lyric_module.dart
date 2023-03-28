
import 'infra/use-cases/lyrics_use_cases.dart';
import 'infra/use-cases/services_use_cases.dart';
import 'infra/models/hive-dtos/lyric_hive_dto.dart';
import 'infra/models/hive-dtos/service_hive_dto.dart';
import 'presentation/blocs/lyric_bloc.dart';
import 'presentation/blocs/service_bloc.dart';
import '../core/external/hive_datasource.dart';
import '../core/infra/repositories/repository.dart';

import 'package:provider/provider.dart';

final hiveLyricModule = [

  Provider<LyricBloc>(
    create: (_) => LyricBloc(
      lyricsUseCase: LyricsUseCases(
        repository: Repository(
          datasource: HiveDatasource<LyricHiveDTO>(boxLabel: 'lyrics'),
        ),
      ),
    ),
  ),

  Provider<ServiceBloc>(
    create: (_) => ServiceBloc(
      servicesUseCases: ServicesUseCases(
        repository: Repository(
          datasource: HiveDatasource<ServiceHiveDTO>(boxLabel: 'services'),
        ),
      ),
    ),
  ),

];
