
import 'package:ipbc_palmas/app/lyric/presentation/blocs/lyric_bloc.dart';
import 'package:ipbc_palmas/app/lyric/presentation/blocs/service_bloc.dart';

import '../core/external/hive_datasource.dart';
import '../core/infra/repositories/repository.dart';
import 'domain/entities/lyric_entity.dart';
import 'domain/entities/service_entity.dart';
import 'package:provider/provider.dart';

import 'infra/use-cases/lyrics_use_cases.dart';
import 'infra/use-cases/services_use_cases.dart';

final hiveModule = [
  Provider<Repository<List<Map<dynamic, dynamic>>>>(
    create: (context) => Repository(
      datasource: HiveDatasource(boxLabel: 'lyric'),
    ),
  ),

  Provider<Repository<List<Map<dynamic, dynamic>>>>(
    create: (context) => Repository(
      datasource: HiveDatasource(boxLabel: 'service'),
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
