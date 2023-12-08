import 'package:core_module/core_module.dart';
import 'package:mocktail/mocktail.dart';

class LyricEntityMock extends Mock implements LyricEntity {}
class CollectionEntityMock extends Mock implements ServiceEntity {}
class ServicesEntityMock extends Mock implements ServicesEntity {}
class AnalyticsMock extends Mock implements AnalyticsUtil {}
class ILyricsUseCasesMock<R> extends Mock implements ILyricsUseCases<R> {}
class IUseCasesMock<R> extends Mock implements IUseCases<R> {}
class RepositoryMock extends Mock implements Repository<List<Map>> {}
class IDatasourceMock extends Mock implements IDatasource {}