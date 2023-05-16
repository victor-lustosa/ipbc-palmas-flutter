import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget(
      {Key? key,
      this.size,
      this.action,
      required this.color,
      this.splashColor,
      this.highlightColor,
      required this.iOSIcon,
      required this.androidIcon})
      : super(key: key);
  final double? size;
  final IconData iOSIcon;
  final IconData androidIcon;
  final Color? color;
  final VoidCallback? action;
  final Color? splashColor;
  final Color? highlightColor;
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: action,
            child: Icon(
              size: size,
              color: color,
              iOSIcon,
            ),
          )
        : IconButton(
            onPressed: action,
            splashColor: splashColor,
            highlightColor: highlightColor,
            icon: Icon(
              size: size,
              androidIcon,
              color: color,
            ),
          );
  }
}
