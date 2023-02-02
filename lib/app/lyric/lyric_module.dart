import '../core/external/firestore_datasource.dart';
import '../core/infra/repositories/repository.dart';
import 'presentation/blocs/lyric_bloc.dart';
import 'domain/entities/lyric_entity.dart';
import 'domain/use-cases/lyrics_use_cases.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'presentation/blocs/weekend_lyrics_bloc.dart';

final lyricModule = [
  Provider<Repository<LyricEntity>>(
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
  Provider<WeekendLyricsBloc>(
    create: (context) => WeekendLyricsBloc(
      lyricsUseCase: LyricsUseCases(
        repository: context.read<Repository<LyricEntity>>(),
      ),
    ),
  ),
];
