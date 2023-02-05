import 'package:flutter/material.dart';
//import '../../../shared/components/back-button/back_button_widget.dart';
import '../../../shared/components/next-button/next_button_widget.dart';
import '../../../shared/layout/top-bar/main_top_bar_widget.dart';

import '../../../shared/configs/app_configs.dart';
import '../../../shared/configs/app_routes.dart';
import 'dart:io';

import '../../infra/models/weekend_dto.dart';

class WeekendLyricsListView extends StatefulWidget {
  const WeekendLyricsListView({super.key});

  @override
  State<WeekendLyricsListView> createState() => _WeekendLyricsListViewState();
}

class _WeekendLyricsListViewState extends State<WeekendLyricsListView>
    with AutomaticKeepAliveClientMixin {
  final List<WeekendDTO> weekendLyrics = const [
    WeekendDTO(
        title: 'Sábado',
        heading: 'sábado',
        url: 'weekday-lyrics/raVXYTMhxE622P75AUzv/evening-saturday'),
    WeekendDTO(
        title: 'Domingo pela manhã',
        heading: 'domingo pela manhã',
        url: 'weekday-lyrics/raVXYTMhxE622P75AUzv/morning-sunday'),
    WeekendDTO(
        title: 'Domingo à noite',
        heading: 'domingo à noite',
        url: 'weekday-lyrics/raVXYTMhxE622P75AUzv/evening-sunday'),
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MainTopBarWidget(),
              /*const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Align(
                  alignment: Alignment(-0.97, 0),
                  child: BackButtonWidget(),
                ),
              ),*/
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 17.0,
                      top: 33,
                    ),
                    child: Text(
                      "Músicas",
                      style: AppFonts.headHome,
                    ),
                  ), /*
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10.0,
                      right: 0,
                    ),
                    child: SizedBox(
                      height: 30,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.lyricRoute,
                          );
                        },
                        icon: const Icon(
                          size: 32,
                          Icons.navigate_next_sharp,
                          color: AppColors.darkGreen,
                        ),
                      ),
                    ),
                  ),*/
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 18.0,
                  top: 8,
                ),
                child: Text(
                  "Acompanhe as letras das músicas cantadas no cultos.",
                  style: AppFonts.subHeadHome,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 28.0,
                ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.93,
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: Platform.isIOS ? 17 : 16,
                      );
                    },
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: weekendLyrics.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(18),
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              AppImages.listImagesWeekend[index],
                            ),
                          ),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.only(
                            top: Platform.isIOS ? 13 : 12.2,
                            bottom: Platform.isIOS ? 13 : 12.2,
                            left: 25,
                            right: 0,
                          ),
                          title: Text(
                            weekendLyrics[index].title,
                            style: AppFonts.titleTile,
                          ),
                          trailing: NextButtonWidget(
                            size: Platform.isIOS ? 29 : 35,
                            route: AppRoutes.lyricRoute,
                            arguments: weekendLyrics[index],
                            color: AppColors.white,
                          ),
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.chosenLyricsRoute,
                                arguments: weekendLyrics[index]);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
