import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';

class NavigationButtonWidget extends StatelessWidget {
  const NavigationButtonWidget(
      {super.key, double? size, this.color, required this.iconName})
      : size = size ?? 23.0;

  final double? size;
  final Color? color;
  final String iconName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Platform.isIOS ? 0 : 1.3),
      child: SizedBox(
        width: size,
        height: size,
        child: SvgPicture.asset(
          color: color,
          iconName,
          matchTextDirection: true,
        ),
      ),
    );
  }
}
