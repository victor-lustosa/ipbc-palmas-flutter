import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget(
      {super.key, this.androidRadius, this.color, this.size, this.iosRadius});
  final double? androidRadius;
  final double? iosRadius;
  final double? size;
  final Color? color;

  @override
  Widget build(context) {
    return SizedBox(
      width: size ?? MediaQuery.of(context).size.width,
      height: size ?? MediaQuery.of(context).size.height,
      child: Center(
        child: Platform.isIOS
            ? CupertinoActivityIndicator(
                color: color ?? AppColors.darkGreen,
                radius: iosRadius ?? 17,
              )
            : CircularProgressIndicator(
                strokeWidth: androidRadius!,
                valueColor: AlwaysStoppedAnimation<Color>(
                  color ?? AppColors.darkGreen,
                ),
              ),
      ),
    );
  }
}
