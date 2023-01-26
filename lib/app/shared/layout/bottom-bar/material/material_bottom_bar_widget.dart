// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../configs/app_configs.dart';
import '../navegation_button_widget.dart';

class MaterialBottomBarWidget extends StatefulWidget {
  final int selectedIndex;

  final Function(int) callback;

  const MaterialBottomBarWidget(
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
      height: 56,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            offset: const Offset(1, 2),
            spreadRadius: 3,
            blurRadius: 7,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
        child: BottomNavigationBar(
          currentIndex: widget.selectedIndex,
          unselectedLabelStyle: AppFonts.selectedBottomNav,
          selectedLabelStyle: AppFonts.selectedBottomNav,
          selectedItemColor: AppColors.darkGreen,
          unselectedItemColor: AppColors.grey,
          backgroundColor: AppColors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: NavegationButtonWidget(
                iconName: AppIcons.home,
                color: AppColors.darkGreen,
              ),
              icon: NavegationButtonWidget(
                iconName: AppIcons.home,
                color: AppColors.grey,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              activeIcon: NavegationButtonWidget(
                iconName: AppIcons.lyricsIconName,
                color: AppColors.darkGreen,
              ),
              icon: NavegationButtonWidget(
                iconName: AppIcons.lyricsIconName,
                color: AppColors.grey,
              ),
              label: 'Músicas',
            ),
            BottomNavigationBarItem(
              activeIcon: NavegationButtonWidget(
                iconName: AppIcons.volunteerActivism,
                color: AppColors.darkGreen,
              ),
              icon: NavegationButtonWidget(
                iconName: AppIcons.volunteerActivism,
                color: AppColors.grey,
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
