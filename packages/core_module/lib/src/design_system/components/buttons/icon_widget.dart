import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core_module.dart';

enum IconFormat { svg, native }

class IconWidget extends StatelessWidget {
  const IconWidget({
    super.key,
    Size? size,
    String? iconName,
    IconFormat? iconFormat,
    this.action,
    this.color,
    this.splashColor,
    this.highlightColor,
    this.iOSIcon,
    this.androidIcon,
    this.sizeIcon,
  }) : size = size ?? const Size(23, 23),
       iconFormat = iconFormat ?? IconFormat.native,
       iconName = iconName ?? '';

  final Size size;
  final String? iconName;
  final IconFormat? iconFormat;
  final double? sizeIcon;
  final IconData? iOSIcon;
  final IconData? androidIcon;
  final Color? color;
  final VoidCallback? action;
  final Color? splashColor;
  final Color? highlightColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height,
      width: size.width,
      child: iconFormat == IconFormat.svg
          ? SvgPicture.asset(
              colorFilter: ColorFilter.mode(
                color ?? AppColors.darkGreen,
                BlendMode.srcIn,
              ),
              iconName!,
            )
          : Icon(
              size: sizeIcon,
              color: color ?? AppColors.darkGreen,
              Platform.isIOS && iOSIcon != null ? iOSIcon : androidIcon,
            ),
    );
  }
}
