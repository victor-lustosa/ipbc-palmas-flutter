import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../infra/repositories/lyric_repository.dart';
import '../../shared/configs/app_fonts.dart';
import '../../shared/configs/app_colors.dart';
import '../../shared/configs/app_icons.dart';
import '../../shared/configs/app_routes.dart';
import '../blocs/lyric_bloc.dart';
import '../domain/use-cases/lyrics_use_cases.dart';

import 'package:flutter_svg/flutter_svg.dart';

class LyricsListView extends StatefulWidget {
  const LyricsListView({super.key});

  @override
  State<LyricsListView> createState() => _LyricsListViewState();
}

class _LyricsListViewState extends State<LyricsListView> {
  late List lyrics;
  late LyricBloc bloc;
  @override
  void initState() {
    lyrics = [];
    bloc = LyricBloc(
        lyricsUseCase:
            LyricsUseCases(repository: context.read<LyricRepository>()));
    bloc.add(GetLyricsEvent());
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
                  return const Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.darkGreen)));
                } else if (state is SuccessfullyFetchedLyricsState) {
                  lyrics = state.entities;
                  return RefreshIndicator(
                    color: AppColors.darkGreen,
                    onRefresh: () async {
                      bloc.add(GetLyricsEvent());
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 80.0),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  /*Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        size: 40,
                                        Icons.navigate_before_rounded,
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),*/
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 28.0),
                                child: SvgPicture.asset(
                                  AppIcons.lyricsIconName,
                                  color: AppColors.black,
                                  matchTextDirection: true,
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 2),
                                  child: Text("Músicas/Letras",
                                      style: AppFonts.h2)),
                            ],
                          ),
                        ),
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: lyrics.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                  title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                                '${lyrics[index].title} - ${lyrics[index].group}',
                                                style: AppFonts.body),
                                          ],
                                        ),
                                        Column(children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, AppRoutes.lyricRoute,
                                              arguments: lyrics[index]
                                              );
                                            },
                                            icon: const Icon(
                                              size: 30,
                                              Icons.navigate_next_rounded,
                                              color: AppColors.darkGreen,
                                            ),
                                          )
                                        ])
                                      ]),
                                  onTap: () {

                                  });
                            }),
                      ],
                    ),
                  );
                } else {
                  return Text('aconteceu um erro [Establishment_page_one]');
                }
              })),
    );
  }
}
