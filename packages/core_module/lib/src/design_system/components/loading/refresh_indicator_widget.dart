import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class RefreshIndicatorWidget extends StatelessWidget {
  const RefreshIndicatorWidget({
    super.key,
    this.color,
    this.elevation,
    this.backgroundColor,
    required this.action,
    required this.child,
  });

  final double? elevation;
  final Color? backgroundColor;
  final Color? color;
  final Future<void> Function() action;
  final Widget child;

  @override
  Widget build(context) {
    return Platform.isAndroid
        ? RefreshIndicator(
            elevation: elevation ?? .7,
            backgroundColor: backgroundColor ?? AppColors.white,
            color: color ?? AppColors.darkGreen,
            onRefresh: action,
            child: child,
          )
        : child;
  }
}
