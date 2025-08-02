import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

actionButton({
  required BuildContext context,
  final Function(bool?)? callback,
  required String icon,
  required String label,
  required double top,
  required double bottom,
  required VoidCallback? action,
}) {
  return ButtonWidget(
    overlayColor: Colors.transparent,
    padding: EdgeInsets.only(top: top, bottom: bottom),
    adaptiveButtonType: AdaptiveButtonType.text,
    action: action,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(right: 10, left: 10),
          height: 20,
          child: Image.asset(icon),
        ),
        Text(
          label,
          style: AppFonts.defaultFont(fontSize: 17, color: AppColors.grey10),
        ),
      ],
    ),
  );
}
