import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class MaterialBottomBarWidget extends StatefulWidget {
  final int selectedIndex;

  final Function(int) callback;

  const MaterialBottomBarWidget({
    super.key,
    required this.selectedIndex,
    required this.callback,
  });

  @override
  State<MaterialBottomBarWidget> createState() =>
      _MaterialBottomBarWidgetState();
}

class _MaterialBottomBarWidgetState extends State<MaterialBottomBarWidget>
    with ButtonsBarMixin {
  @override
  initState() {
    super.initState();
    buildButtonsBar();
  }

  BorderRadius get border => const BorderRadius.only(
    topRight: Radius.circular(22),
    topLeft: Radius.circular(22),
  );

  TextStyle? get labelFont =>
      AppFonts.defaultFont(fontSize: 12, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: border,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: .4),
            offset: const Offset(1, 2),
            spreadRadius: 3,
            blurRadius: 7,
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: border,
        child: BottomNavigationBar(
          currentIndex: widget.selectedIndex,
          unselectedLabelStyle: labelFont,
          selectedLabelStyle: labelFont,
          selectedItemColor: AppColors.darkGreen,
          unselectedItemColor: AppColors.grey5,
          backgroundColor: AppColors.white,
          items: buttons,
          onTap: (newValue) {
            setState(() {
              widget.callback(newValue);
            });
          },
        ),
      ),
    );
  }
}

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
      MenuItem(AppIcons.volunteerActivism, 'Ofertas'),
    ];

    buttons =
        menuItemsList
            .map(
              (MenuItem menuItem) => BottomNavigationBarItem(
            activeIcon: items(menuItem.iconData, AppColors.darkGreen),
            icon: items(menuItem.iconData, AppColors.grey5),
            label: menuItem.label,
          ),
        )
            .toList();

    return buttons;
  }

  Widget items(String iconData, Color color) {
    return IconWidget(
      iconFormat: IconFormat.svg,
      size: iconData == AppIcons.home ?const Size(19.5, 19.5) : const Size(19, 19),
      iconName: iconData,
      color: color,
    );
  }
}
