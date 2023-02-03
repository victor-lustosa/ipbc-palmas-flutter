import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../configs/app_configs.dart';
import '../layout/bottom-bar/navegation_button_widget.dart';

class MenuItem {
  const MenuItem(this.iconData, this.label);
  final String iconData;
  final String label;
}

class ButtonsBarMixin {
  List<BottomNavigationBarItem> buttons = [];

  List<BottomNavigationBarItem> buildButtonsBar() {
    const List<MenuItem> menuItensList = <MenuItem>[
      MenuItem(AppIcons.home, 'Home'),
      MenuItem(AppIcons.lyricsIconName, 'Músicas'),
      MenuItem(AppIcons.volunteerActivism, 'Ofertas')
    ];

    buttons = menuItensList
        .map((MenuItem menuItem) => BottomNavigationBarItem(
              activeIcon: NavegationButtonWidget(
                size: Platform.isIOS ? 23 : 22,
                iconName: menuItem.iconData,
                color: AppColors.darkGreen,
              ),
              icon: NavegationButtonWidget(
                size: Platform.isIOS ? 23 : 22,
                iconName: menuItem.iconData,
                color: AppColors.grey,
              ),
              label: menuItem.label,
            ))
        .toList();
    return buttons;
  }
}
