import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../configs/app_configs.dart';


class TopBarWidget extends StatelessWidget {
  const TopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Stack(
          fit: StackFit.loose,
          children: [
            Align(
              alignment: const Alignment(-1.05, 0.65),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 25,
                  top: 0,
                ),
                child: SizedBox(
                  width: 75,
                  height: 75,
                  child: SvgPicture.asset(
                    AppIcons.logo,
                    color: AppColors.darkGreen,
                    matchTextDirection: true,
                  ),
                ),
              ),
            ),
            Align(
              alignment: MediaQuery.of(context).orientation.name == 'portrait'
                  ? const Alignment(0.67, 0.23)
                  : const Alignment(0.77, -0.2),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(3),
                    shape: MaterialStateProperty.all(
                      const CircleBorder(),
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.all(6),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                        AppColors.darkGreen), // <-- Button color
                  ),
                  child: const Icon(
                    size: 23,
                    Icons.search_sharp,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            Align(
              alignment: MediaQuery.of(context).orientation.name == 'portrait'
                  ? const Alignment(0.98, 0.24)
                  : const Alignment(0.92, -0.2),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 5,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(AppColors.white),
                    elevation: const MaterialStatePropertyAll(0),
                    shape: MaterialStateProperty.all(
                      const CircleBorder(),
                    ),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.all(7),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                        AppColors.white), // <-- Button color
                  ),
                  child: const Icon(
                    size: 35,
                    Icons.menu_rounded,
                    color: AppColors.darkGreen,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
