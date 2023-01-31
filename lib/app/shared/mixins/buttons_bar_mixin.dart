import 'package:flutter/cupertino.dart';

import '../configs/app_configs.dart';
import '../layout/bottom-bar/navegation_button_widget.dart';

class ButtonsBarMixin {
  List<BottomNavigationBarItem> buttons = [];

  List<BottomNavigationBarItem> buildButtonsBar() {
    List<String> appIcons = [
      AppIcons.home,
      AppIcons.lyricsIconName,
      AppIcons.volunteerActivism
    ];

    List<String> appLabels = ['Home', 'Músicas', 'Ofertas'];

    for (int i = 0; i < appIcons.length; i++) {
      buttons.add(
        BottomNavigationBarItem(
          activeIcon: NavegationButtonWidget(
            iconName: appIcons[i],
            color: AppColors.darkGreen,
          ),
          icon: NavegationButtonWidget(
            iconName: appIcons[i],
            color: AppColors.grey,
          ),
          label: appLabels[i],
        ),
      );
    }
    return buttons;
  }
}
