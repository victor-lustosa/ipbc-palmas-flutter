import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class NavigationButtonWidget extends StatelessWidget {
  const NavigationButtonWidget(
      {super.key, double? size, this.color, required this.iconName})
      : size = size ?? 23.0;

  final double? size;
  final Color? color;
  final String iconName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        colorFilter: ColorFilter.mode(
          color ?? AppColors.darkGreen, BlendMode.srcIn,),
        iconName,
        matchTextDirection: true,
      ),
    );
  }
}
