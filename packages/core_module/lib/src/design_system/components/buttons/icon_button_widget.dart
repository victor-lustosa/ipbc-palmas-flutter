import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core_module.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    super.key,
    this.size,
    this.action,
    this.color,
    this.splashColor,
    this.highlightColor,
    this.iOSIcon,
    this.androidIcon,
    this.sizeIcon,
    this.iconName,
    IconFormat? iconFormat,
  }) : iconFormat = iconFormat ?? IconFormat.native;

  final String? iconName;
  final double? size;
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
      height: size,
      width: size,
      child: iconFormat == IconFormat.svg
          ? InkWell(
              onTap: action,
              child: SvgPicture.asset(
                colorFilter: ColorFilter.mode(
                  color ?? AppColors.darkGreen,
                  BlendMode.srcIn,
                ),
                iconName!,
              ),
            )
          : Platform.isIOS && iOSIcon != null
          ? CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: action,
              child: Icon(
                size: sizeIcon ?? size,
                color: color ?? AppColors.darkGreen,
                iOSIcon,
              ),
            )
          : IconButton(
              padding: EdgeInsets.zero,
              onPressed: action,
              splashColor: splashColor,
              highlightColor: highlightColor,
              icon: Icon(
                size: sizeIcon ?? size,
                androidIcon,
                color: color ?? AppColors.darkGreen,
              ),
            ),
    );
  }
}
