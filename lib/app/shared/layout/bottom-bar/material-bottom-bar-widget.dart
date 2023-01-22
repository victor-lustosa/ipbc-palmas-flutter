// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../configs/app_configs.dart';

class MaterialBottomBarWidget extends StatefulWidget {
  int selectedIndex;

  final Function(int) callback;

  MaterialBottomBarWidget(
      {Key? key, required this.selectedIndex, required this.callback})
      : super(key: key);

  @override
  State<MaterialBottomBarWidget> createState() =>
      _MaterialBottomBarWidgetState();
}

class _MaterialBottomBarWidgetState extends State<MaterialBottomBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(24), topLeft: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              offset: const Offset(1, 2),
              spreadRadius: 3,
              blurRadius: 7,
              blurStyle: BlurStyle.outer),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        child: BottomNavigationBar(
          selectedFontSize: 12,
          elevation: 10,
          currentIndex: widget.selectedIndex,
          unselectedLabelStyle: AppFonts.selectedBottomNav,
          selectedLabelStyle: AppFonts.selectedBottomNav,
          selectedItemColor: AppColors.darkGreen,
          unselectedItemColor: AppColors.grey,
          backgroundColor: AppColors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: widget.selectedIndex == 0
                  ? SizedBox(
                      width: 25,
                      height: 25,
                      child: SvgPicture.asset(
                        color: AppColors.darkGreen,
                        AppIcons.home,
                        matchTextDirection: true,
                      ),
                    )
                  : SizedBox(
                      width: 25,
                      height: 25,
                      child: SvgPicture.asset(
                        color: AppColors.grey,
                        AppIcons.home,
                        matchTextDirection: true,
                      ),
                    ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: widget.selectedIndex == 1
                  ? SizedBox(
                      width: 25,
                      height: 25,
                      child: SvgPicture.asset(
                        color: AppColors.darkGreen,
                        AppIcons.lyricsIconName,
                        matchTextDirection: true,
                      ),
                    )
                  : SizedBox(
                      width: 25,
                      height: 25,
                      child: SvgPicture.asset(
                        color: AppColors.grey,
                        AppIcons.lyricsIconName,
                        matchTextDirection: true,
                      ),
                    ),
              label: 'Músicas',
            ),
            BottomNavigationBarItem(
              icon: widget.selectedIndex == 2
                  ? SizedBox(
                      width: 25,
                      height: 25,
                      child: SvgPicture.asset(
                        color: AppColors.darkGreen,
                        AppIcons.volunteerActivism,
                        matchTextDirection: true,
                      ),
                    )
                  : SizedBox(
                      width: 25,
                      height: 25,
                      child: SvgPicture.asset(
                        color: AppColors.grey,
                        AppIcons.volunteerActivism,
                        matchTextDirection: true,
                      ),
                    ),
              label: 'Ofertas',
            ),
          ],
          onTap: (newValue) {
            setState(
              () {
                widget.callback(newValue);
              },
            );
          },
        ),
      ),
    );
  }
}
