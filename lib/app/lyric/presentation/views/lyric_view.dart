import 'package:flutter/material.dart';
import 'package:ipbc_palmas/app/shared/components/back-button/back_button_widget.dart';
import '../../../shared/configs/app_configs.dart';
import '../../../shared/configs/app_routes.dart';
import '../../domain/entities/lyric_entity.dart';

import 'package:flutter_svg/flutter_svg.dart';

class LyricView extends StatelessWidget {
  const LyricView({super.key, required this.lyricEntity});

  final LyricEntity lyricEntity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      const BackButtonWidget(
                        color: AppColors.darkGreen,
                        size: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          top: 10,
                        ),
                        child: SvgPicture.asset(
                          AppIcons.lyricsIconName,
                          color: AppColors.black,
                          matchTextDirection: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 7,
                        ),
                        child: Text(
                          lyricEntity.title,
                          style: AppFonts.h2,
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: const Alignment(-0.40, 0),
                    child: Text(
                      lyricEntity.group,
                      style: AppFonts.subtitle,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                ),
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 15,
                    );
                  },
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: lyricEntity.verses.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: lyricEntity.verses[index].isChorus == true
                          ? const EdgeInsets.only(
                              left: 18.0,
                              right: 18,
                            )
                          : const EdgeInsets.only(
                              left: 8.0,
                              right: 0.0,
                            ),
                      child: Container(
                        alignment: lyricEntity.verses[index].isChorus == true
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        decoration: lyricEntity.verses[index].isChorus == true
                            ? BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(
                                  color: AppColors.lightGrey,
                                ),
                                color: AppColors.lightGrey,
                              )
                            : BoxDecoration(
                                color: AppColors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                border: Border.all(
                                  color: AppColors.white,
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                ),
                              ),
                        child: ListTile(
                          title: ListView.builder(
                            itemCount:
                                lyricEntity.verses[index].versesList.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: ((context, position) {
                              return ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0.0,
                                  horizontal: 0.0,
                                ),
                                dense: true,
                                title: Text(
                                  lyricEntity
                                      .verses[index].versesList[position],
                                  style: AppFonts.lyricTile,
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
