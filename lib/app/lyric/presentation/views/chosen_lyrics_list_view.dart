import 'package:flutter/material.dart';
import 'package:ipbc_palmas/app/shared/layout/top-bar/main_top_bar_widget.dart';

import '../../../shared/components/back-button/back_button_widget.dart';
//import '../../../shared/components/next-button/next_button_widget.dart';
import '../../../shared/configs/app_configs.dart';
//import '../../../shared/configs/app_routes.dart';
import '../../domain/entities/lyric_entity.dart';
import '../components/lyrics_list_widget.dart';

class ChosenLyricsListView extends StatelessWidget {
  ChosenLyricsListView({super.key});

  final List<LyricEntity> lyricsFetched = [
    LyricEntity(
        id: '0',
        title: "Vim para adorar-te",
        group: "Vineyard",
        verses: [],
        albumCover:
            'http://coverartarchive.org/release/ce82afc5-f866-400e-adcd-4a23c01dd877/4433492734-500.jpg'),
    LyricEntity(
        id: "1",
        title: "Redenção",
        group: 'Projeto Sola',
        verses: [],
        albumCover:
            'http://coverartarchive.org/release/ce82afc5-f866-400e-adcd-4a23c01dd877/4433492734-500.jpg'),
    LyricEntity(
        id: "2",
        title: "Oh quão lindo esse nome é",
        group: 'Ana Nóbrega',
        albumCover:
            'http://coverartarchive.org/release/ce82afc5-f866-400e-adcd-4a23c01dd877/4433492734-500.jpg',
        verses: [])
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const MainTopBarWidget(),
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Align(
                alignment: Alignment(-0.97, 0),
                child: BackButtonWidget(
                  color: AppColors.darkGreen,
                  size: 30,
                ),
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
              child: LyricsListWidget(
                lyricsList: lyricsFetched,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
