import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ipbc_palmas/app/lyric/presentation/blocs/lyric_bloc.dart';
import 'package:ipbc_palmas/app/shared/components/utils/analytics_util.dart';
import 'package:ipbc_palmas/app/lyric/domain/use-cases/lyrics_use_cases.dart';
import 'package:ipbc_palmas/app/lyric/presentation/view-models/lyrics_view_model.dart';
import '../../../mocks/mocks.dart';

void main() {
  late ILyricsUseCases<Stream<List<LyricEntityMock>>> useCases;
  late LyricBloc bloc;
  late AnalyticsUtil analyticsUtil;
  late LyricsViewModel lyricsViewModel;

  setUp(
    () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      analyticsUtil = AnalyticsMock();
      lyricsViewModel = LyricsViewModelMock();
      useCases = ILyricsUseCasesMock<Stream<List<LyricEntityMock>>>();

      bloc = LyricBloc(
        fireLyricsUseCase: useCases,
        hiveLyricsUseCase: useCases,
        lyricsViewModel: lyricsViewModel,
        analyticsUtil: analyticsUtil,
      );
    },
  );

  blocTest<LyricBloc, LyricState>(
    'Fetching lyrics of firestore',
    build: () {
      when(() => lyricsViewModel.isConnected())
          .thenAnswer((_) => Future.value(true));
      when(() => useCases.get('lyrics/20')).thenAnswer(
        (_) => Future.value(
          Stream.value(
            [LyricEntityMock()],
          ),
        ),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(CheckConnectivityEvent()),
    expect: () => [
      isA<LyricsSuccessfullyFetchedState>(),
    ],
  );

  blocTest<LyricBloc, LyricState>(
    'Fetching lyrics of firestore and occorring an error',
    build: () {
      when(() => lyricsViewModel.isConnected())
          .thenAnswer((_) => Future.value(true));
      when(() => useCases.get('lyrics/20')).thenAnswer(
        (_) async => Stream.error(
          Exception('Error'),
          StackTrace.fromString('stackTraceString'),
        ),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(CheckConnectivityEvent()),
    expect: () => [
      isA<ExceptionLyricState>(),
    ],
  );

  blocTest<LyricBloc, LyricState>(
    'Fetching lyrics of hive',
    build: () {
      when(() => useCases.get('lyrics/20')).thenAnswer(
        (_) => Future.value(
          Stream.value(
            [LyricEntityMock()],
          ),
        ),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(GetLyricsInHiveEvent()),
    expect: () => [
      isA<LyricsSuccessfullyFetchedState>(),
    ],
  );

  blocTest<LyricBloc, LyricState>(
    'Fetching lyrics of hive and occorring an error',
    build: () {
      when(() => useCases.get('lyrics/20')).thenAnswer(
        (_) async => Stream.error(
          Exception('Error'),
          StackTrace.fromString('stackTraceString'),
        ),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(GetLyricsInHiveEvent()),
    expect: () => [
      isA<ExceptionLyricState>(),
    ],
  );
}
