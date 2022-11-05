import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../configs/app_colors.dart';
import '../../configs/app_icons.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25, top: 0),
          child: SizedBox(
            width: 76,
            height: 76,
            child: SvgPicture.asset(
              AppIcons.logo,
              color: AppColors.darkGreen,
              matchTextDirection: true,
            ),
          ),
        ),
        const SizedBox(width: 150),
        ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            elevation: const MaterialStatePropertyAll(3),
            shape: MaterialStateProperty.all(const CircleBorder()),
            padding: MaterialStateProperty.all(const EdgeInsets.all(6)),
            backgroundColor: MaterialStateProperty.all(
                AppColors.darkGreen), // <-- Button color
          ),
          child: const Icon(
            size: 26,
            Icons.search_sharp,
            color: AppColors.white,
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: SizedBox(width: 0,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(AppColors.white),
                  elevation: const MaterialStatePropertyAll(0),
                  shape: MaterialStateProperty.all(const CircleBorder()),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(7)),
                  backgroundColor: MaterialStateProperty.all(
                      AppColors.white), // <-- Button color
                ),
                child: const Icon(
                  size: 39,
                  Icons.menu_rounded,
                  color: AppColors.darkGreen,
                ),
              ),
            )),
      ],
    );
  }
}
