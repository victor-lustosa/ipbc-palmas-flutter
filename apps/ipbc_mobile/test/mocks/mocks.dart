import 'package:core_module/core_module.dart';
import 'package:ipbc_palmas/app/shared/view-models/services_view_model.dart';
import 'package:mocktail/mocktail.dart';

class LyricEntityMock extends Mock implements LyricEntity {}
class CollectionEntityMock extends Mock implements ServiceEntity {}
class ServicesEntityMock extends Mock implements ServicesEntity {}
class AnalyticsMock extends Mock implements AnalyticsUtil {}
class ServicesViewModelMock extends Mock implements ServicesViewModel {}
class ILyricsUseCasesMock<R> extends Mock implements ILyricsUseCases<R> {}
class IUseCasesMock<R> extends Mock implements IUseCases<R> {}
class RepositoryMock extends Mock implements Repository<Stream<List<Map>>> {}
class IDatasourceMock extends Mock implements IDatasource {}