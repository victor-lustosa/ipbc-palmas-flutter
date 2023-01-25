import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavegationButtonWidget extends StatelessWidget {
  const NavegationButtonWidget(
      {super.key, required this.size, this.color, required this.iconName});

  final double size;
  final Color? color;
  final String iconName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: SvgPicture.asset(
        color: color,
        iconName,
        matchTextDirection: true,
      ),
    );
  }
}
