import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipbc_palmas/app/lyric/external/datasource/lyric_firestore_datasource.dart';
import 'package:ipbc_palmas/app/lyric/infra/repositories/lyric_repository.dart';
import 'package:ipbc_palmas/app/shared/configs/app_fonts.dart';
import '../../shared/configs/app_colors.dart';
import '../../shared/configs/app_routes.dart';
import '../blocs/lyric_bloc.dart';
import '../domain/use-cases/lyrics_use_cases.dart';


class LyricsView extends StatefulWidget {
  const LyricsView({super.key});

  @override
  State<LyricsView> createState() => _LyricsViewState();
}

class _LyricsViewState extends State<LyricsView> {
  late List lyrics;
  late LyricBloc bloc;
  @override
  void initState() {
    lyrics = [];

    bloc = LyricBloc(
        lyricsUseCase: LyricsUseCases(
            repository: LyricRepository(
                datasource: LyricFirestoreDatasource(
                    firestore: ))));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(color: AppColors.white),
          child: BlocBuilder<LyricBloc, LyricState>(
              bloc: bloc,
              buildWhen: (context, current) =>
                  context.runtimeType != current.runtimeType &&
                  (current is SuccessfullyFetchedLyricsState),
              builder: (context, state) {
                if (state is InitialState) {
                  return Stack(
                      fit: StackFit.loose,
                      alignment: Alignment.center,
                      children: const [
                        Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.darkGreen)))
                      ]);
                } else if (state is SuccessfullyFetchedLyricsState) {
                  lyrics = state.entities;
                  return RefreshIndicator(
                      color: AppColors.darkGreen,
                      onRefresh: () async {
                        bloc.add(GetLyricsEvent());
                      },
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: lyrics.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                title: Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Text(lyrics[index].name,
                                        style: AppFonts.body)),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.lyricRoute);
                                });
                          }));
                } else {
                  return Text('aconteceu um erro [Establishment_page_one]');
                }
              })),
    );
  }
}
