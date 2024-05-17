import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget(
      {super.key,
        this.size,
        this.action,
        required this.color,
        this.splashColor,
        this.highlightColor,
        required this.iOSIcon,
        required this.androidIcon, this.sizeIcon});
  final double? size;
  final double? sizeIcon;
  final IconData iOSIcon;
  final IconData androidIcon;
  final Color? color;
  final VoidCallback? action;
  final Color? splashColor;
  final Color? highlightColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Platform.isIOS
          ? CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: action,
        child: Icon(
          size: sizeIcon ?? size,
          color: color,
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
          color: color,
        ),
      ),
    );
  }
}