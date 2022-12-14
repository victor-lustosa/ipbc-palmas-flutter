import 'package:ipbc_palmas/app/core/infra/datasources/datasource.dart';
import 'package:ipbc_palmas/app/core/infra/repositories/repository.dart';
import 'package:ipbc_palmas/app/lyric/domain/entities/lyric_entity.dart';
import 'package:ipbc_palmas/app/lyric/domain/use-cases/lyrics_use_cases.dart';
import 'package:mocktail/mocktail.dart';

class RepositoryMock extends Mock implements Repository<LyricEntity> {}

class LyricEntityMock extends Mock implements LyricEntity {}

class IGetDatasourceMock extends Mock implements IGetDatasource {}

class ILyricsUseCasesMock extends Mock implements ILyricsUseCases {}
