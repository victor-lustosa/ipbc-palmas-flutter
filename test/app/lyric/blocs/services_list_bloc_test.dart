import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ipbc_palmas/app/core/domain/use-cases/use_cases.dart';
import 'package:ipbc_palmas/app/shared/components/utils/analytics_util.dart';
import 'package:ipbc_palmas/app/lyric/presentation/blocs/services_list_bloc.dart';
import 'package:ipbc_palmas/app/lyric/presentation/view-models/lyrics_view_model.dart';
import '../../../mocks/mocks.dart';

void main() {
  late IUseCases<Stream<List<ServicesEntityMock>>> useCases;
  late ServicesListBloc bloc;
  late AnalyticsUtil analyticsUtil;
  late LyricsViewModel lyricsViewModel;

  setUp(
        () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      analyticsUtil = AnalyticsMock();
      lyricsViewModel = LyricsViewModelMock();
      useCases = IUseCasesMock<Stream<List<ServicesEntityMock>>>();

      bloc = ServicesListBloc(
        fireUseCases: useCases,
        hiveUseCases: useCases,
        lyricsViewModel: lyricsViewModel,
        analyticsUtil: analyticsUtil,
      );
    },
  );

  blocTest<ServicesListBloc, ServicesListState>(
    'Fetching services list of firestore',
    build: () {
      when(() => lyricsViewModel.isConnected())
          .thenAnswer((_) => Future.value(true));
      when(() => useCases.get('services/20')).thenAnswer(
            (_) => Future.value(
          Stream.value(
            [ServicesEntityMock()],
          ),
        ),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(CheckConnectivityEvent()),
    expect: () => [
      isA<SuccessfullyFetchedServiceState>(),
    ],
  );

  blocTest<ServicesListBloc, ServicesListState>(
    'Fetching services list of firestore and occorring an error',
    build: () {
      when(() => lyricsViewModel.isConnected())
          .thenAnswer((_) => Future.value(true));
      when(() => useCases.get('services/20')).thenAnswer(
            (_) async => Stream.error(
          Exception('Error'),
          StackTrace.fromString('stackTraceString'),
        ),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(CheckConnectivityEvent()),
    expect: () => [
      isA<ServiceExceptionState>(),
    ],
  );

  blocTest<ServicesListBloc, ServicesListState>(
    'Fetching services list of hive',
    build: () {
      when(() => useCases.get('services/20')).thenAnswer(
            (_) => Future.value(
          Stream.value(
            [ServicesEntityMock()],
          ),
        ),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(GetServiceInHiveEvent()),
    expect: () => [
      isA<SuccessfullyFetchedServiceState>(),
    ],
  );

  blocTest<ServicesListBloc, ServicesListState>(
    'Fetching services list of hive and occorring an error',
    build: () {
      when(() => useCases.get('services/20')).thenAnswer(
            (_) async => Stream.error(
          Exception('Error'),
          StackTrace.fromString('stackTraceString'),
        ),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(GetServiceInHiveEvent()),
    expect: () => [
      isA<ServiceExceptionState>(),
    ],
  );
}
