import '../core/external/firestore_datasource.dart';
import '../core/infra/repositories/repository.dart';
import 'domain/entities/service_entity.dart';
import 'infra/use-cases/lyrics_use_cases.dart';
import 'infra/use-cases/services_use_cases.dart';
import 'presentation/blocs/lyric_bloc.dart';
import 'domain/entities/lyric_entity.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'presentation/blocs/service_bloc.dart';

final lyricModule = [
  Provider<Repository<LyricEntity>>(
    create: (context) => Repository(
      getDatasource: FirestoreDatasource(
        firestore: FirebaseFirestore.instance,
      ),
    ),
  ),
  Provider<Repository<ServiceEntity>>(
    create: (context) => Repository(
      getDatasource: FirestoreDatasource(
        firestore: FirebaseFirestore.instance,
      ),
    ),
  ),
  Provider<LyricBloc>(
    create: (context) => LyricBloc(
      lyricsUseCase: LyricsUseCases(
        repository: context.read<Repository<LyricEntity>>(),
      ),
    ),
  ),
  Provider<ServiceBloc>(
    create: (context) => ServiceBloc(
      servicesUseCases: ServicesUseCases(
        repository: context.read<Repository<ServiceEntity>>(),
      ),
    ),
  ),
];
