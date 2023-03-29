import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';

import 'package:ipbc_palmas/app/lyric/presentation/blocs/lyric_bloc.dart';
import 'package:ipbc_palmas/app/lyric/domain/use-cases/lyrics_use_cases.dart';

import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  late ILyricsUseCases<Stream<List<LyricEntityMock>>> fireUseCases;
  late ILyricsUseCases<Stream<List<LyricEntityMock>>> HiveUseCases;
  late LyricBloc bloc;

  setUp(() {
    fireUseCases = ILyricsUseCasesMock<Stream<List<LyricEntityMock>>>();
    HiveUseCases = ILyricsUseCasesMock<Stream<List<LyricEntityMock>>>();
    bloc = LyricBloc(fireLyricsUseCase: fireUseCases, hiveLyricsUseCase: HiveUseCases);
  });

  blocTest<LyricBloc, LyricState>(
    'Fetching lyrics of firestore',
    build: () {
      when(() => fireUseCases.get('')).thenAnswer((_) => Future.value(Stream.value([])));
      return bloc;
    },
    act: (bloc) => bloc.add(GetLyricsInFireEvent(path: '')),
    expect: () => [
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
      isA<ExceptionLyricState>(),
    ],
  );
}
