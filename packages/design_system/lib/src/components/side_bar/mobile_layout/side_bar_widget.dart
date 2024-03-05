import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SideBarWidget extends StatelessWidget {
  final List<String> drawerNames;

  const SideBarWidget({
    required this.drawerNames,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 205.0,
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        child: SizedBox(
          height: context.mediaQuery.size.height * 0.67,
          width: context.mediaQuery.size.width * 0.76,
          child: Drawer(
            backgroundColor: AppColors.white,
            child: Stack(
              alignment: const Alignment(-0.6, -0.9),
              children: [
                Align(
                  alignment: const Alignment(-0.875, -0.9),
                  child: SizedBox(
                    height: 34,
                    width: 34,
                    child: SvgPicture.asset(
                      AppIcons.accountCircle,
                      colorFilter: const ColorFilter.mode(
                          AppColors.darkGreen, BlendMode.srcIn),
                      matchTextDirection: true,
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(-0.54, -0.89),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 14.0,
                    ),
                    child: Text(
                      'Victor',
                      style: AppFonts.defaultFont(
                        color: AppColors.darkGreen,
                        fontSize: 26.3,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const Alignment(0.85, -0.92),
                  child: IconButton(
                    onPressed: () {
                      Scaffold.of(context).closeEndDrawer();
                    },
                    icon: const Icon(
                      size: 31,
                      Icons.close_sharp,
                      color: AppColors.darkGreen,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 47.0,
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: drawerNames.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: const EdgeInsets.only(
                          left: 15,
                          bottom: 1,
                          top: 1,
                        ),
                        title: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 1,
                              ),
                              child: SizedBox(
                                height: 25,
                                width: 25,
                                child: SvgPicture.asset(
                                  AppIcons.sideBarIconsList[index],
                                  colorFilter: const ColorFilter.mode(
                                      AppColors.black, BlendMode.srcIn),
                                  matchTextDirection: true,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 18.0,
                              ),
                              child: Text(
                                drawerNames[index],
                                style: AppFonts.defaultFont(
                                  color: Colors.black,
                                  fontSize: 16.7,
                                ),
                              ),
                            )
                          ],
                        ),
                        onTap: () {
                          // Navigator.pushNamed(context, AppRoutes.lyricRoute,
                          //    arguments: lyricsFiltered[index]);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
