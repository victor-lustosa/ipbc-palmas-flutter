import 'package:core_module/core_module.dart';
import 'package:ipbc_palmas/app/lyric/view-models/lyrics_view_model.dart';

class LyricEntityMock extends Mock implements LyricEntity {}
class CollectionEntityMock extends Mock implements ServiceEntity {}
class ServicesEntityMock extends Mock implements ServicesEntity {}
class AnalyticsMock extends Mock implements AnalyticsUtil {}
class LyricsViewModelMock extends Mock implements LyricsViewModel {}
class ILyricsUseCasesMock<R> extends Mock implements ILyricsUseCases<R> {}
class IUseCasesMock<R> extends Mock implements IUseCases<R> {}
class RepositoryMock extends Mock implements Repository<Stream<List<Map>>> {}
class IDatasourceMock extends Mock implements IDatasource {}