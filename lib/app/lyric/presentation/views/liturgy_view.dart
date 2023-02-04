import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../infra/models/liturgy_dto.dart';
import '../../../shared/components/back-button/back_button_widget.dart';
import '../../../shared/configs/app_configs.dart';
import '../../../shared/layout/top-bar/main_top_bar_widget.dart';
import '../../domain/entities/lyric_entity.dart';
import '../../infra/models/weekend_dto.dart';
import '../blocs/weekend_lyrics_bloc.dart';
import '../components/lyrics_list_widget.dart';
import 'dart:io';

class LiturgyView extends StatefulWidget {
  const LiturgyView({super.key, required this.weekendDTO});
  final WeekendDTO weekendDTO;

  @override
  State<LiturgyView> createState() => _LiturgyViewState();
}

class _LiturgyViewState extends State<LiturgyView> {
  late WeekendLyricsBloc bloc;
  late List<LyricEntity> lyricsFetched;
  final List<LiturgyDTO> liturgyList = <LiturgyDTO>[
    LiturgyDTO(isAdditional: false, sequence: 'Oração', additional: ''),
    LiturgyDTO(
        isAdditional: true,
        sequence: 'Texto Biblico',
        additional: 'João 10:1-6'),
    LiturgyDTO(
        isAdditional: true, sequence: 'Hino 151', additional: 'O Bom Pastor'),
    LiturgyDTO(
        isAdditional: true,
        sequence: 'Texto Biblico',
        additional: 'Lucas 15:1-7'),
    LiturgyDTO(
        isAdditional: false,
        sequence: 'Oração de confissão de pecados',
        additional: ''),
    LiturgyDTO(isAdditional: false, sequence: 'Cânticos', additional: ''),
    LiturgyDTO(
        isAdditional: true, sequence: 'Pregação', additional: 'Salmos 23'),
    LiturgyDTO(isAdditional: false, sequence: 'Santa Ceia', additional: ''),
    LiturgyDTO(isAdditional: false, sequence: 'Oração Final', additional: ''),
    LiturgyDTO(isAdditional: false, sequence: 'Avisos', additional: ''),
  ];
  @override
  void initState() {
    lyricsFetched = [];
    bloc = context.read<WeekendLyricsBloc>();
    bloc.add(GetWeekendLyricsEvent(url: widget.weekendDTO.url));
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
                      GetWeekendLyricsEvent(url: widget.weekendDTO.url),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const MainTopBarWidget(),
                      const Padding(
                        padding: EdgeInsets.only(
                          top: 16.0,
                        ),
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
                        padding: EdgeInsets.only(
                            top: Platform.isIOS ? 16 : 16, bottom: 11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Align(
                                alignment: const Alignment(-1, 0),
                                child: Text(
                                  "Liturgia do Culto",
                                  style: AppFonts.headline,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: AppColors.badgeGreen,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(34.7))),
                                height: 26,
                                child: Align(
                                  alignment: const Alignment(0, 0),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 13),
                                    child: Text(
                                      "${widget.weekendDTO.title} 05/01/2023",
                                      style: AppFonts.liturgyBadge,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        // color: Colors.cyan,
                        width: MediaQuery.of(context).size.width * 0.955,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: liturgyList.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        width: 2,
                                        height: 21,
                                        color: index == 0
                                            ? Colors.white
                                            : AppColors.timelineGuideTGreen,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        padding: const EdgeInsets.all(3.2),
                                        decoration: BoxDecoration(
                                            color:
                                                AppColors.timelineCircleGreen,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                      ),
                                      Container(
                                        width: 2,
                                        height: 21,
                                        color: index == liturgyList.length - 1
                                            ? Colors.white
                                            : AppColors.timelineGuideTGreen,
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      height: 32.5,
                                      child: Row(
                                        children: <Widget>[
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              liturgyList[index].sequence,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                color:
                                                    AppColors.timelinePrimary,
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible:
                                                liturgyList[index].isAdditional,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 13,
                                              ),
                                              child: Text(
                                                liturgyList[index].additional,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: AppColors
                                                      .timelineSecondary,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
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
                                "Músicas de ${widget.weekendDTO.heading}",
                                style: AppFonts.headline,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: Platform.isIOS ? 10.0 : 11,
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
              child: Text("erro na tela [liturgy_view]"),
            );
          }
        },
      ),
    );
  }
}
