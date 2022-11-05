import 'package:flutter/material.dart';
import 'package:ipbc_palmas/app/lyric/domain/entities/verse_entity.dart';
import 'package:ipbc_palmas/app/lyric/infra/models/verse_dto.dart';

import '../../shared/components/utils/util.dart';
import '../../shared/configs/app_colors.dart';
import '../../shared/configs/app_fonts.dart';
import '../../shared/configs/app_icons.dart';
import '../domain/entities/lyric_entity.dart';

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
              Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            size: 43,
                            Icons.navigate_before_rounded,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SvgPicture.asset(
                        AppIcons.lyricsIconName,
                        color: AppColors.black,
                        matchTextDirection: true,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(lyricEntity.title, style: AppFonts.h2)),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 64.0, bottom: 10),
                  child: Row(
                    children: [
                      Text(lyricEntity.group, style: AppFonts.subtitle),
                    ],
                  )),
              ListView.separated(
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
                          ? const EdgeInsets.only(left: 18.0, right: 18)
                          : const EdgeInsets.only(left: 8.0, right: 0.0),
                      child: Container(
                        alignment: lyricEntity.verses[index].isChorus == true
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        decoration: lyricEntity.verses[index].isChorus == true
                            ? BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(color: AppColors.lightGrey),
                                color: AppColors.lightGrey)
                            : BoxDecoration(
                                color: AppColors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                border: Border.all(
                                    color: AppColors.white,
                                    width: 1.0,
                                    style: BorderStyle.solid)),
                        child: ListTile(
                            title: ListView.builder(
                          itemCount: lyricEntity.verses[index].versesList.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: ((context, position) {
                            return ListTile(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0.0, horizontal: 0.0),
                                dense: true,
                                title: Text(
                                    lyricEntity
                                        .verses[index].versesList[position],
                                    style: AppFonts.lyricTile));
                          }),
                        )),
                      ),
                    );
                  }),
              const Padding(padding: EdgeInsets.only(top: 20)),
            ]),
          ),
        ));
  }
}
