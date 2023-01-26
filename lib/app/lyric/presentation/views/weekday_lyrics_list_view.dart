import 'package:flutter/material.dart';
import '../../../shared/components/back-button/back_button_widget.dart';
import '../../../shared/components/next-button/next_button_widget.dart';
import '../../../shared/layout/top-bar/main_top_bar_widget.dart';

import '../../../shared/configs/app_configs.dart';
import '../../../shared/configs/app_routes.dart';

class WeekdayLyricsListView extends StatelessWidget {
  //const WeekdayLyricsList({Key? key, required this.weekdayLyrics}) : super(key: key);
  WeekdayLyricsListView({super.key});
  final List<String> weekdayLyrics = [
    'Sábado',
    'Domingo de manha',
    'Domingo de noite'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                top: 10,
              ),
              child: Text(
                "Acompanhe as letras das músicas cantadas no culto.",
                style: AppFonts.subHeadHome,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
              ),
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: weekdayLyrics.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    width: 10,
                    decoration: BoxDecoration(color: Colors.amber),
                    child: ListTile(
                      contentPadding: const EdgeInsets.only(
                        top: 13,
                        bottom: 13,
                        left: 25,
                        right: 0,
                      ),
                      title: Text(
                        weekdayLyrics[index],
                        style: AppFonts.titleTile,
                      ),
                      trailing: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.orange,
                          ),
                        ),
                        child: NextButtonWidget(
                          route: AppRoutes.lyricRoute,
                          arguments: weekdayLyrics[index],
                          color: AppColors.white,
                        ),
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.lyricRoute,
                          arguments: weekdayLyrics[index],
                        );
                      },
                    ),
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
