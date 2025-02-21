import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class TitleTopBarWidget extends StatelessWidget {
  const TitleTopBarWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 37, right: 16, left: 16),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*const Padding(
            padding: EdgeInsets.only(left: 11.0),
            child: BackButtonWidget(),
          ),*/
          // const SizedBox(),
          Text(title, style: AppFonts.title3()),
          /*const Padding(
            padding: EdgeInsets.only(left: 4.0),
            child: CircleAvatarWidget(),
          ),*/
        ],
      ),
    );
  }
}
