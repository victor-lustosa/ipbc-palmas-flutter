import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core_module.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    super.key,
    this.height,
    this.width,
    this.action,
    this.color,
    this.splashColor,
    this.highlightColor,
    this.iOSIcon,
    this.androidIcon,
    this.sizeIcon,
    this.iconPath,
    IconFormat? iconFormat,
  }) : iconFormat = iconFormat ?? IconFormat.native;

  final String? iconPath;
  final double? height;
  final double? width;
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
    if (iconFormat == IconFormat.svg) {
      return SizedBox(
        width: width,
        height: height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: action,
            child: Center(
              child: SvgPicture.asset(
                colorFilter: ColorFilter.mode(
                  color ?? AppColors.darkGreen,
                  BlendMode.srcIn,
                ),
                iconPath!,
                width: sizeIcon,
                height: sizeIcon,
              ),
            ),
          ),
        ),
      );
    }

    final iconWidget = Icon(
      size: sizeIcon,
      color: color ?? AppColors.darkGreen,
      (Platform.isIOS && iOSIcon != null) ? iOSIcon : androidIcon,
    );

    final Widget button;
    if (Platform.isIOS && iOSIcon != null) {
      button = CupertinoButton(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        onPressed: action,
        child: iconWidget,
      );
    } else {
      button = IconButton(
        padding: EdgeInsets.zero,
        onPressed: action,
        splashColor: splashColor,
        highlightColor: highlightColor,
        constraints: BoxConstraints(),
        icon: iconWidget,
      );
    }

    return SizedBox(
      width: width ?? sizeIcon,
      height: height ?? sizeIcon,
      child: button,
    );
  }
}