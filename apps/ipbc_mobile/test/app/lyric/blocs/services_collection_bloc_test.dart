
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_module/core_module.dart';
import 'package:ipbc_palmas/app/shared/components/utils/analytics_util.dart';
import 'package:ipbc_palmas/app/lyric/presentation/view-models/lyrics_view_model.dart';
import 'package:ipbc_palmas/app/lyric/presentation/blocs/services_collection_bloc.dart';
import 'package:mocktail/mocktail.dart';
import '../../../mocks/mocks.dart';

void main() {
  late IUseCases<Stream<List<CollectionEntityMock>>> useCases;
  late ServicesCollectionBloc bloc;
  late AnalyticsUtil analyticsUtil;
  late LyricsViewModel lyricsViewModel;

  setUp(
        () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      analyticsUtil = AnalyticsMock();
      lyricsViewModel = LyricsViewModelMock();
      useCases = IUseCasesMock<Stream<List<CollectionEntityMock>>>();

      bloc = ServicesCollectionBloc(
        fireUseCases: useCases,
        hiveUseCases: useCases,
        lyricsViewModel: lyricsViewModel,
        analyticsUtil: analyticsUtil,
      );
    },
  );

  blocTest<ServicesCollectionBloc, ServicesCollectionState>(
    'Fetching services collection of firestore',
    build: () {
      when(() => lyricsViewModel.isConnected())
          .thenAnswer((_) => Future.value(true));
      when(() => useCases.get('saturday-services/20')).thenAnswer(
            (_) => Future.value(
          Stream.value(
            [CollectionEntityMock()],
          ),
        ),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(CheckConnectivityEvent(path:'saturday-services/20')),
    expect: () => [
      isA<CollectionSuccessfullyFetchedState>(),
    ],
  );

  blocTest<ServicesCollectionBloc, ServicesCollectionState>(
    'Fetching services collection of firestore and occorring an error',
    build: () {
      when(() => lyricsViewModel.isConnected())
          .thenAnswer((_) => Future.value(true));
      when(() => useCases.get('saturday-services/20')).thenAnswer(
            (_) async => Stream.error(
          Exception('Error'),
          StackTrace.fromString('stackTraceString'),
        ),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(CheckConnectivityEvent(path:'saturday-services/20')),
    expect: () => [
      isA<ServiceExceptionState>(),
    ],
  );

  blocTest<ServicesCollectionBloc, ServicesCollectionState>(
    'Fetching services collection of hive',
    build: () {
      when(() => useCases.get('services-collection/saturday-services/20')).thenAnswer(
            (_) => Future.value(
          Stream.value(
            [CollectionEntityMock()],
          ),
        ),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(GetServicesCollectionInHiveEvent(path:'saturday-services/20')),
    expect: () => [
      isA<CollectionSuccessfullyFetchedState>(),
    ],
  );

  blocTest<ServicesCollectionBloc, ServicesCollectionState>(
    'Fetching services collection of hive and occorring an error',
    build: () {
      when(() => useCases.get('services-collection/saturday-services/20')).thenAnswer(
            (_) async => Stream.error(
          Exception('Error'),
          StackTrace.fromString('stackTraceString'),
        ),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(GetServicesCollectionInHiveEvent(path:'saturday-services/20')),
    expect: () => [
      isA<ServiceExceptionState>(),
    ],
  );
}
