import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:ipbc_palmas/app/shared/components/top-bar/top_bar_widget.dart';

import '../../../shared/components/back-button/back_button_widget.dart';
import '../../../shared/components/next-button/next_button_widget.dart';
import '../../../shared/configs/app_configs.dart';
import '../../../shared/configs/app_routes.dart';
import '../../domain/entities/lyric_entity.dart';

class ChosenLyricsListView extends StatelessWidget {
  ChosenLyricsListView({super.key});

  List<LyricEntity> lyricsFetched = [
    LyricEntity(
        id: '0', title: "Vim para adorar-te", group: "Vineyard", verses: []),
    LyricEntity(id: "1", title: "Redenção", group: 'Projeto Sola', verses: []),
    LyricEntity(
        id: "2",
        title: "Oh quão lindo esse nome é",
        group: 'Ana Nóbrega',
        verses: [])
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const TopBarWidget(),
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Align(
                alignment: Alignment(-0.97, 0),
                child: BackButtonWidget(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Align(
                alignment: const Alignment(-0.74, 0),
                child: Text(
                  "Músicas de domingo de manhã",
                  style: AppFonts.headline,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
              ),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: lyricsFetched.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.only(
                      top: 4,
                      bottom: 4,
                      left: 25,
                      right: 17,
                    ),
                    dense: true,
                    minVerticalPadding: 0,
                    minLeadingWidth: 0,
                    horizontalTitleGap: 8,
                    leading: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(
                          AppImages.userAvatar,
                        ),
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 6.5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            lyricsFetched[index].title,
                            style: AppFonts.titleTile,
                          ),
                        ],
                      ),
                    ),
                    subtitle: Text(
                      lyricsFetched[index].group,
                      style: AppFonts.subtitleTile,
                    ),
                    trailing: Container(
                        /*  decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.orange,
                                  ),
                                ),*/
                        child: NextButtonWidget(
                            route: AppRoutes.lyricRoute,
                            arguments: lyricsFetched[index],
                            color: AppColors.darkGreen)),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.lyricRoute,
                        arguments: lyricsFetched[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
