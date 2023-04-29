import 'package:ipbc_palmas/app/core/infra/datasources/datasource.dart';
import 'package:ipbc_palmas/app/core/infra/repositories/repository.dart';
import 'package:ipbc_palmas/app/lyric/domain/entities/lyric_entity.dart';
import 'package:ipbc_palmas/app/lyric/domain/use-cases/lyrics_use_cases.dart';
import 'package:ipbc_palmas/app/lyric/infra/models/hive-dtos/hive_database_configs_dto.dart';
import 'package:ipbc_palmas/app/lyric/presentation/view-models/lyrics_view_model.dart';
import 'package:mocktail/mocktail.dart';

class RepositoryMock extends Mock implements Repository<Stream<List<Map>>> {}

class LyricEntityMock extends Mock implements LyricEntity {}

class IDatasourceMock extends Mock implements IDatasource {}

class LyricsViewModelMock extends Mock implements LyricsViewModel {}
class ILyricsUseCasesMock<R> extends Mock implements ILyricsUseCases<R> {}

class HiveDatabaseConfigsDTOMock extends Mock implements HiveDatabaseConfigsDTO{}