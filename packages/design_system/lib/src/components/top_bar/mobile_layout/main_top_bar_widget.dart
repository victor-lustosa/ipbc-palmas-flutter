import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../../circle_avatar/circle_avatar_widget.dart';

class MainTopBarWidget extends StatelessWidget {
  const MainTopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Container(
          margin: const EdgeInsets.only(top: 32, left: 16, right: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 78,
                height: 32,
                child: SvgPicture.asset(
                  AppIcons.logo,
                  colorFilter: const ColorFilter.mode(
                    AppColors.darkGreen,
                    BlendMode.srcIn,
                  ),
                  //  height: 75,width: 75,
                ),
              ),
               const CircleAvatarWidget(),
            ],
          ),
        );
      },
    );
  }
}
