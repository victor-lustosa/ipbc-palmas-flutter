import 'package:flutter/material.dart';

import '../../../shared/configs/app_configs.dart';

class TitleTopBarWidget extends StatelessWidget {
  const TitleTopBarWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 37),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*const Padding(
            padding: EdgeInsets.only(left: 11.0),
            child: BackButtonWidget(),
          ),*/
          Text(
            title,
            style: AppFonts.titleLyricsView,
          ),
          // const Padding(
          //   padding: EdgeInsets.only(left: 4.0),
          //   child: CircleAvatarWidget(),
          // ),
        ],
      ),
    );
  }
}
