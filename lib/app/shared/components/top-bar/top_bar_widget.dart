import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../configs/app_colors.dart';
import '../../configs/app_icons.dart';

class TopBarWidget extends PreferredSize {
  TopBarWidget({super.key}) : super(
    preferredSize: const Size.fromHeight(80),
    child: Builder(
      builder: (context) {
        return Container(
            decoration: const BoxDecoration(color: AppColors.white),
            child:Stack(
              fit: StackFit.loose,
              children: [
                Align(
                  alignment: const Alignment(-1, 0.16),
                  child: Padding(
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
                ),

                Align(
                  alignment: MediaQuery.of(context).orientation.name == 'portrait' ? const Alignment(0.6,-0.2): const Alignment(0.77,-0.2),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ElevatedButton(
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
                  ),
                ),
                Align(
                  alignment: MediaQuery.of(context).orientation.name == 'portrait' ? const Alignment(0.92, -0.2): const Alignment(0.92,-0.2),
                  child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: ElevatedButton(
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
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
                      )),
                ),
              ],
            )
        );
      }
    ),
  );

}
