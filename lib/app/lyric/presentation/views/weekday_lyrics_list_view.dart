import 'package:flutter/material.dart';
import 'package:ipbc_palmas/app/shared/components/back-button/back_button_widget.dart';
import 'package:ipbc_palmas/app/shared/components/next-button/next_button_widget.dart';
import 'package:ipbc_palmas/app/shared/components/top-bar/top_bar_widget.dart';

import '../../../shared/configs/app_configs.dart';
import '../../../shared/configs/app_routes.dart';

class WeekdayLyricsListView extends StatelessWidget {

  //const WeekdayLyricsList({Key? key, required this.weekdayLyrics}) : super(key: key);
   WeekdayLyricsListView({Key? key}) : super(key: key);
  final List<String> weekdayLyrics = ['Culto de manha', 'Culto de noite'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
        child: Column(
          children: [
            const TopBarWidget(),
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Align(
                alignment: Alignment(-0.97,0),
                child: BackButtonWidget(),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(
              top: 11.0,
            ),
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: weekdayLyrics.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 50,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 0,
                    color: AppColors.grey,
                    child: ListTile(
                      contentPadding: const EdgeInsets.only(
                        top: 16,
                        bottom: 16,
                        left: 25,
                        right: 17,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 6.5,
                        ),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              weekdayLyrics[index],
                              style: AppFonts.titleTile,
                            ),
                          ],
                        ),
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
                            arguments: weekdayLyrics[index],
                         color:AppColors.white)
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.lyricRoute,
                          arguments: weekdayLyrics[index],
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),],
        ),
      ),
    );
  }
}
