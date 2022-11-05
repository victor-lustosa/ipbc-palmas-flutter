import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../configs/app_colors.dart';
import '../../configs/app_icons.dart';

class TopBarWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding:
          const EdgeInsets.only(left: 25, top: 0),
          child: SvgPicture.asset(
            AppIcons.logo,
            color: AppColors.darkGreen,
            width: 46,
            height: 46,
            matchTextDirection: true,
          ),
        ),
        const SizedBox(width: 160),
        Padding(
            padding: const EdgeInsets.only(
                left: 0.0, bottom: 5),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                    const CircleBorder()),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.all(7)),
                backgroundColor:
                MaterialStateProperty.all(AppColors
                    .darkGreen), // <-- Button color
              ),
              child: const Icon(
                size: 26,
                Icons.search_sharp,
                color: AppColors.white,
              ),
            )),
      ],
    );
  }

}