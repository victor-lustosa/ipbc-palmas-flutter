//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:ipbc_palmas/app/lyric/presentation/blocs/lyric_bloc.dart';
import 'package:ipbc_palmas/app/lyric/domain/use-cases/lyrics_use_cases.dart';
import 'package:ipbc_palmas/app/lyric/presentation/view-models/lyrics_view_model.dart';
//import 'package:ipbc_palmas/firebase_options.dart';
//import 'package:flutter_test/flutter_test.dart';
//import '../../core/external/firebase_mock.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';
//import '../../core/external/firebase_mock.dart';
void main() {
  late ILyricsUseCases<Stream<List<LyricEntityMock>>> fireUseCases;
  late ILyricsUseCases<Stream<List<LyricEntityMock>>> fiveUseCases;
  late LyricBloc bloc;
  late LyricsViewModel lyricsViewModel;
  FirebaseCrashlytics? analytics;
  MockFirebaseApp app = MockFirebaseApp();
    setUpAll(() async {
      TestWidgetsFlutterBinding.ensureInitialized();

      await app.initializeApp('dsf',PigeonFirebaseOptions(apiKey: 'dfs', appId: 'dfs', messagingSenderId: 'sdfsd', projectId: 'sfsd'));
      analytics = FirebaseCrashlytics.instance;

    });

  setUp(() async {

    fireUseCases = ILyricsUseCasesMock<Stream<List<LyricEntityMock>>>();
    fiveUseCases = ILyricsUseCasesMock<Stream<List<LyricEntityMock>>>();
    lyricsViewModel = LyricsViewModelMock();
    bloc = LyricBloc(fireLyricsUseCase: fireUseCases, hiveLyricsUseCase: fiveUseCases, lyricsViewModel: lyricsViewModel);
  });

  blocTest<LyricBloc, LyricState>(
    'Fetching lyrics of firestore',
    build: () {
      when(() => lyricsViewModel.isConnected()).thenAnswer((_) => Future.value(true));
      when(() => fireUseCases.get('lyrics/20')).thenAnswer((_) => Future.value(Stream.value([LyricEntityMock()])));
      return bloc;
    },
    act: (bloc) => bloc.add(CheckConnectivityEvent()),
    expect: () => [
      isA<SuccessfullyFetchedLyricsState>(),
    ],
  );
  blocTest<LyricBloc, LyricState>(
    'Fetching lyrics of firestore and occorring an error',
    build: () {

      when(() => lyricsViewModel.isConnected()).thenAnswer((_) => Future.value(true));
      when(() => fireUseCases.get('lyrics/20')).thenAnswer((_) => Future.value(Stream.error(Exception('Error'))));
      return bloc;
    },
    act: (bloc) => bloc.add(CheckConnectivityEvent()),
    expect: () => [
      analytics!.log('app_clear_data'),
      isA<ExceptionLyricState>(),
    ],
  );
}
