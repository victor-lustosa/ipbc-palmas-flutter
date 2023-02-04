import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/back-button/back_button_widget.dart';
import '../../../shared/configs/app_configs.dart';
import '../../../shared/layout/top-bar/main_top_bar_widget.dart';
import '../../domain/entities/lyric_entity.dart';
import '../blocs/weekend_lyrics_bloc.dart';
import '../components/lyrics_list_widget.dart';
import 'dart:io';

class ChosenLyricsListView extends StatefulWidget {
  const ChosenLyricsListView(
      {super.key, required this.url, required this.heading});
  final String heading;
  final String url;
  @override
  State<ChosenLyricsListView> createState() => _ChosenLyricsListViewState();
}

class _ChosenLyricsListViewState extends State<ChosenLyricsListView> {
  late WeekendLyricsBloc bloc;
  late List<LyricEntity> lyricsFetched;

  @override
  void initState() {
    lyricsFetched = [];
    bloc = context.read<WeekendLyricsBloc>();
    bloc.add(GetWeekendLyricsEvent(url: widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeekendLyricsBloc, WeekendLyricsState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is InitialState) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.darkGreen,
                ),
              ),
            );
          } else if (state is SuccessfullyFetchedWeekendLyricsState) {
            lyricsFetched = state.entities;

            return SafeArea(
              child: SingleChildScrollView(
                child: RefreshIndicator(
                  color: AppColors.darkGreen,
                  onRefresh: () async {
                    bloc.add(
                      GetWeekendLyricsEvent(url: widget.url),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const MainTopBarWidget(),
                      const Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: Align(
                          alignment: Alignment(-0.97, 0),
                          child: BackButtonWidget(
                            iOSIcon: CupertinoIcons.chevron_back,
                            androidIcon: Icons.arrow_back_rounded,
                            color: AppColors.darkGreen,
                            size: 30,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Platform.isIOS ? 24 : 20),
                        child: Align(
                          alignment: Alignment(Platform.isIOS ? -0.4 : -0.3, 0),
                          child: SizedBox(
                            height: 25,
                            width: 350,
                            child: Align(
                              alignment: const Alignment(-1, 0),
                              child: Text(
                                "Músicas de ${widget.heading}.",
                                style: AppFonts.headline,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: Platform.isIOS ? 16.0 : 11,
                        ),
                        child: LyricsListWidget(
                          lyricsList: lyricsFetched,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: Text("erro na tela [chosen lyrics list view]"),
            );
          }
        },
      ),
    );
  }
}
