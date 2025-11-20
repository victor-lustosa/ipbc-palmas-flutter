import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

import '../constraints/layout_responsive.dart';
import 'tab_button/tab_buttons_widget.dart';

class TopBarWidget extends StatefulWidget {
  final VoidCallback onLocationTap;
  final VoidCallback onServicesTap;
  final VoidCallback onAppTap;
  final VoidCallback onContactTap;

  const TopBarWidget({
    super.key,
    required this.onLocationTap,
    required this.onServicesTap,
    required this.onAppTap,
    required this.onContactTap,
  });

  @override
  State<TopBarWidget> createState() => _TopBarWidgetState();
}

class _TopBarWidgetState extends State<TopBarWidget> {
  late double vWidth;
  bool isPressed = false;
  final double lgSize = 1200;

  @override
  Widget build(BuildContext context) {
    vWidth = context.sizeOf.width;

    if (vWidth < 600) {
      return mobile();
    } else if (vWidth < 915) {
      return tablet();
    } else {
      return web();
    }
  }

  Column web() => Column(
    children: [
      Container(
        margin: upperMargin(value: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            logo(),
            SizedBox(
              width: 693,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 400,
                    margin: const EdgeInsets.only(right: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TabButtonsWidget(
                          label: 'Localização',
                          action: widget.onLocationTap,
                        ),
                        TabButtonsWidget(
                          label: 'Programação',
                          action: widget.onServicesTap,
                        ),
                        TabButtonsWidget(
                          label: 'Aplicativo',
                          action: widget.onAppTap,
                        ),
                      ],
                    ),
                  ),
                  contactButton(
                    width: 259,
                    height: 49,
                    leftMargin: 16,
                    label: 'Entrar em contato',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Container(
        height: 0.4,
        decoration: const BoxDecoration(color: AppColors.grey5),
      ),
    ],
  );

  Column tablet() => Column(
    children: [
      Container(
        margin: upperMargin(value: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            logo(),
            contactButton(
              width: 259,
              height: 49,
              leftMargin: 16,
              label: 'Entrar em contato',
            ),
          ],
        ),
      ),
      Container(
        height: 0.4,
        decoration: const BoxDecoration(color: AppColors.grey5),
      ),
    ],
  );

  Column mobile() => Column(
    children: [
      Container(
        margin: upperMargin(value: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            logo(),
            contactButton(
              width: 166,
              height: 49,
              leftMargin: 8,
              label: 'Contato',
            ),
          ],
        ),
      ),
      Container(
        height: 0.4,
        decoration: const BoxDecoration(color: AppColors.grey5),
      ),
    ],
  );

  Image logo() => const Image(width: 100, image: AssetImage(AppImages.logo));

  SizedBox contactButton({
    required double width,
    required double height,
    required double leftMargin,
    required String label,
  }) => SizedBox(
    width: width,
    height: height,
    child: ButtonWidget(
      style: AppFonts.defaultFont(fontWeight: FontWeight.w500),
      foregroundColor: isPressed ? AppColors.grey12 : AppColors.white,
      shadowColor: AppColors.grey6,
      backgroundColor: isPressed
          ? AppColors.highlightGreen
          : AppColors.darkGreen,
      action: _onContactPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label),
          Container(
            margin: EdgeInsets.only(left: leftMargin),
            child: Image.asset(
              isPressed ? AppIcons.contactIconDarkGreen : AppIcons.contactIcon,
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    ),
  );

  EdgeInsets upperMargin({required double value}) => EdgeInsets.only(
    top: value,
    bottom: value,
    left: TopBarResponsive.leftWidth(vWidth),
    right: TopBarResponsive.rightWidth(vWidth),
  );

  Future<void> _onContactPressed() async {
    setState(() {
      isPressed = true;
    });

    await Future.delayed(const Duration(milliseconds: 300));

    widget.onContactTap();

    await Future.delayed(const Duration(milliseconds: 600));

    if (mounted) {
      setState(() {
        isPressed = false;
      });
    }
  }
}
