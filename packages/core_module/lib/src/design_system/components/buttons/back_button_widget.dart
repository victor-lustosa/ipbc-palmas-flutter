import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BackButtonWidget extends StatelessWidget {
  final void Function()? action;
  final Color? color;
  final double? height;
  final double? sizeIcon;
  final double? width;

  const BackButtonWidget({
    super.key,
    required this.action,
    this.color,
    this.height,
    this.width, this.sizeIcon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButtonWidget(
      height: height ?? 33,
      sizeIcon: sizeIcon ?? 23,
      width: width ?? 33,
      color: color ?? AppColors.darkGreen,
      iconFormat: IconFormat.svg,
      action: action,
      iconPath: AppIcons.arrowBack,
    );
  }
}
