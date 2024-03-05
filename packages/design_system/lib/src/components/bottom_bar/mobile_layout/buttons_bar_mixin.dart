import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'navegation_button_widget.dart';

class MenuItem {
  const MenuItem(this.iconData, this.label);
  final String iconData;
  final String label;
}

mixin ButtonsBarMixin {
  List<BottomNavigationBarItem> buttons = [];

  List<BottomNavigationBarItem> buildButtonsBar() {
    const List<MenuItem> menuItemsList = <MenuItem>[
      MenuItem(AppIcons.home, 'Home'),
      MenuItem(AppIcons.lyrics, 'Músicas'),
      MenuItem(AppIcons.volunteerActivism, 'Ofertas')
    ];

    buttons = menuItemsList.map(
          (MenuItem menuItem) => BottomNavigationBarItem(
            activeIcon: items(menuItem.iconData, AppColors.darkGreen),
            icon: items(menuItem.iconData,  AppColors.grey5),
            label: menuItem.label,
          ),
        ).toList();

    return buttons;
  }
  Widget items(String iconData, Color color){
    return NavigationButtonWidget(
      size: iconData == AppIcons.home ? 19.5: 19,
      iconName: iconData,
      color: color,
    );
  }
}
