import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';

class NavegationButtonWidget extends StatelessWidget {
  const NavegationButtonWidget(
      {super.key, double? size, this.color, required this.iconName})
      : size = size ?? 22.0;

  final double size;
  final Color? color;
  final String iconName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Platform.isIOS ? 0 : 2.3),
      child: SizedBox(
        width: Platform.isIOS ? 23 : size,
        height: Platform.isIOS ? 23 : size,
        child: SvgPicture.asset(
          color: color,
          iconName,
          matchTextDirection: true,
        ),
      ),
    );
  }
}
