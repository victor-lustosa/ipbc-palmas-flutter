import 'package:flutter_test/flutter_test.dart';

import 'package:bloc_test/bloc_test.dart';

import 'package:ipbc_palmas/app/lyric/presentation/blocs/lyric_bloc.dart';
import 'package:ipbc_palmas/app/lyric/domain/use-cases/lyrics_use_cases.dart';

import 'package:mocktail/mocktail.dart';

import '../../../mocks/mocks.dart';

void main() {
  late ILyricsUseCases useCases;
  late LyricBloc bloc;

  setUp(() {
    useCases = ILyricsUseCasesMock();
    bloc = LyricBloc(lyricsUseCase: useCases);
  });

  blocTest<LyricBloc, LyricState>(
    'Fetching lyrics of firestore',
    build: () {
      when(() => useCases.get()).thenAnswer((_) => Stream.value([]));
      return bloc;
    },
    act: (bloc) => bloc.add(GetLyricsEvent()),
    expect: () => [
      isA<SuccessfullyFetchedLyricsState>(),
    ],
  );
  blocTest<LyricBloc, LyricState>(
    'Fetching lyrics of firestore and occorring an error',
    build: () {
      when(() => useCases.get())
          .thenAnswer((_) => Stream.error(Exception('Error')));
      return bloc;
    },
    act: (bloc) => bloc.add(GetLyricsEvent()),
    expect: () => [
      isA<ExceptionLyricState>(),
    ],
  );
}
