
import 'package:home_module/home_module.dart';
import 'package:mocktail/mocktail.dart';

class LyricEntityMock extends Mock implements LyricEntity {}
class CollectionEntityMock extends Mock implements ServiceEntity {}
class ServicesEntityMock extends Mock implements ServicesEntity {}
class AnalyticsMock extends Mock implements AnalyticsUtil {}
class ILyricsUseCasesMock<R> extends Mock implements ILyricsUseCases<R> {}
class IUseCasesMock<R> extends Mock implements IUseCases<R> {}