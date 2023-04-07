import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import '../../../shared/configs/app_configs.dart';
//import '../../../shared/components/circle-avatar/circle_avatar_widget.dart';

class MainTopBarWidget extends StatelessWidget {
  const MainTopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 23, left: 16),
              child: SizedBox(
                width: 76,
                height: 41,
                child: SvgPicture.asset(
                  AppIcons.logo,
                  color: AppColors.darkGreen,
                  //  height: 75,width: 75,
                ),
              ),
            ),
            /* Padding(
              padding: const EdgeInsets.only(top: 4.5),
              child: Align(
                  alignment:
                      MediaQuery.of(context).orientation.name == 'portrait'
                          ? const Alignment(0.985, 0)
                          : const Alignment(1, 0),
                  child: const CircleAvatarWidget()),
            ),*/
          ],
        );
      },
    );
  }
}
