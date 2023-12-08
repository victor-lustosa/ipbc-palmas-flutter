/*import 'package:ipbc_palmas/app/service/blocs/home_bloc.dart';
import 'package:ipbc_palmas/app/shared/blocs/generics.dart';
import 'package:ipbc_palmas/app/shared/view-models/services_view_model.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:core_module/core_module.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/mocks.dart';
void main() {
  late IUseCases<Stream<List<ServicesEntityMock>>> useCases;
  late ServicesListBloc bloc;
  late AnalyticsUtil analyticsUtil;
  late ServicesViewModel servicesViewModel;

  setUp(
        () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      analyticsUtil = AnalyticsMock();
      servicesViewModel = ServicesViewModelMock();
      useCases = IUseCasesMock<Stream<List<ServicesEntityMock>>>();

      bloc = ServicesListBloc(
        fireUseCases: useCases,
        hiveUseCases: useCases,
        viewModel: servicesViewModel,
        analyticsUtil: analyticsUtil,
      );
    },
  );

  /*blocTest<ServicesListBloc, ServicesListState>(
    'Fetching services list of firestore',
    build: () {
      when(() => servicesViewModel.isConnected())
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
      isA<ServiceSuccessfullyFetchedState>(),
    ],
  );*/

  blocTest<ServicesListBloc, GenericState<ServicesListState>>(
    'Fetching services list of firestore and occorring an error',
    build: () {
      when(() => servicesViewModel.isConnected())
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
      isA<ExceptionState>(),
    ],
  );

  blocTest<ServicesListBloc, GenericState<ServicesListState>>(
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
    act: (bloc) => bloc.add(GetInHiveEvent()),
    expect: () => [
      isA<DataFetchedState>(),
    ],
  );

  blocTest<ServicesListBloc, GenericState<ServicesListState>>(
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
    act: (bloc) => bloc.add(GetInHiveEvent()),
    expect: () => [
      isA<ExceptionState>(),
    ],
  );
}
*/