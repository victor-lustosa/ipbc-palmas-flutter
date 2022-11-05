import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipbc_palmas/app/shared/components/top-bar/top_bar_widget.dart';

import '../infra/repositories/lyric_repository.dart';
import '../../shared/configs/app_fonts.dart';
import '../../shared/configs/app_colors.dart';
import '../../shared/configs/app_icons.dart';
import '../../shared/configs/app_routes.dart';
import '../blocs/lyric_bloc.dart';
import '../domain/use-cases/lyrics_use_cases.dart';

import 'package:flutter_svg/flutter_svg.dart';

class LyricsList2View extends StatefulWidget {
  const LyricsList2View({super.key});

  @override
  State<LyricsList2View> createState() => _LyricsList2ViewState();
}

class _LyricsList2ViewState extends State<LyricsList2View> {
  late List lyrics;
  late List<String> lettersCarousel;
  late LyricBloc bloc;
  fillLettersCarousel() {
    var aCode = 'A'.codeUnitAt(0);
    var zCode = 'Z'.codeUnitAt(0);
    lettersCarousel = List<String>.generate(
      zCode - aCode + 1,
      (index) => String.fromCharCode(aCode + index),
    );
  }

  @override
  void initState() {
    lyrics = [];
    lettersCarousel = [];
    fillLettersCarousel();
    bloc = LyricBloc(
        lyricsUseCase:
            LyricsUseCases(repository: context.read<LyricRepository>()));
    bloc.add(GetLyricsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                    child: SizedBox(
                          height: 120,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: lettersCarousel.length,
                            itemBuilder: (context, index) => Column(
                              children: [
                              Text(lettersCarousel[index])
                              ],
                            ),
                          ),
                        ));


                } else {
                  return Text('aconteceu um erro [Establishment_page_one]');
                }
              }),
        ),
      ),
    );
  }
}
