import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';

import 'package:ipbc_palmas/app/lyric/presentation/blocs/lyric_bloc.dart';
import 'package:ipbc_palmas/app/lyric/domain/use-cases/lyrics_use_cases.dart';
import 'package:ipbc_palmas/app/lyric/presentation/view-models/lyrics_view_model.dart';

import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  late ILyricsUseCases<Stream<List<LyricEntityMock>>> fireUseCases;
  late ILyricsUseCases<Stream<List<LyricEntityMock>>> fiveUseCases;
  late LyricBloc bloc;
  late LyricsViewModel lyricsViewModel;
  setUp(() {
    fireUseCases = ILyricsUseCasesMock<Stream<List<LyricEntityMock>>>();
    fiveUseCases = ILyricsUseCasesMock<Stream<List<LyricEntityMock>>>();
    lyricsViewModel = LyricsViewModelMock();
    bloc = LyricBloc(fireLyricsUseCase: fireUseCases, hiveLyricsUseCase: fiveUseCases, lyricsViewModel: lyricsViewModel);
  });

  blocTest<LyricBloc, LyricState>(
    'Fetching lyrics of firestore',
    build: () {
      when(() => fireUseCases.get('')).thenAnswer((_) => Future.value(Stream.value([])));
      return bloc;
    },
    act: (bloc) => bloc.add(GetLyricsInFireEvent(path: '')),
    expect: () => [
      isA<LoadingLyricsState>(),
      isA<SuccessfullyFetchedLyricsState>(),
    ],
  );
  blocTest<LyricBloc, LyricState>(
    'Fetching lyrics of firestore and occorring an error',
    build: () {
      when(() => fireUseCases.get(''))
          .thenAnswer((_) => Future.value(Stream.error(Exception('Error'))));
      return bloc;
    },
    act: (bloc) => bloc.add(GetLyricsInFireEvent(path: '')),
    expect: () => [
      isA<LoadingLyricsState>(),
      isA<ExceptionLyricState>(),
    ],
  );
}
