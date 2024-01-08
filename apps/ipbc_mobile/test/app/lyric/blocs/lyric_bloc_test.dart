/*import 'package:ipbc_palmas/app/shared/blocs/generics.dart';
import 'package:ipbc_palmas/app/shared/view-models/services_view_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ipbc_palmas/app/lyrics/blocs/lyric_bloc.dart';
import '../../../mocks/mocks.dart';
void main() {
  late ILyricsUseCases<Stream<List<LyricEntityMock>>> useCases;
  late LyricBloc bloc;
  late AnalyticsUtil analyticsUtil;
  late ServicesViewModel servicesViewModel;

  setUp(
    () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      analyticsUtil = AnalyticsMock();
      servicesViewModel = ServicesViewModelMock();
      useCases = ILyricsUseCasesMock<Stream<List<LyricEntityMock>>>();

      bloc = LyricBloc(
        fireUseCase: useCases,
        hiveUseCase: useCases,
        viewModel: servicesViewModel,
        analyticsUtil: analyticsUtil,
      );
    },
  );

/*  blocTest<LyricBloc, LyricState>(
    'Fetching lyrics of firestore',
    build: () {
      when(() => servicesViewModel.isConnected())
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
    act: (bloc) => [
      bloc.add(CheckConnectivityEvent()),
      bloc.add(UpdateLyricsInHiveEvent(entities: LyricEntityMock()))
    ]
     ,
    expect: () => [
      isA<LyricsSuccessfullyFetchedState>(),
    ],
  );*/

  blocTest<LyricBloc, GenericState<LyricState>>(
    'Fetching lyrics of firestore and occorring an error',
    build: () {
      when(() => servicesViewModel.isConnected())
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
      isA<ExceptionState>(),
    ],
  );

  blocTest<LyricBloc, GenericState<LyricState>>(
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
    act: (bloc) => bloc.add(GetInHiveEvent()),
    expect: () => [
      isA<DataFetchedState>(),
    ],
  );

  blocTest<LyricBloc, GenericState<LyricState>>(
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
    act: (bloc) => bloc.add(GetInHiveEvent()),
    expect: () => [
      isA<ExceptionState>(),
    ],
  );
}
*/