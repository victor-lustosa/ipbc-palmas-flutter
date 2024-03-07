import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../design_system.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key, this.androidRadius, this.color, this.size, this.iosRadius}) : super(key: key);
  final double? androidRadius;
  final double? iosRadius;
  final double? size;
  final Color? color;
  @override
  Widget build(context) {
    return Platform.isIOS
        ? SizedBox(
            width: size ?? MediaQuery.of(context).size.width,
            height: size ?? MediaQuery.of(context).size.height,
            child: Center(
              child: CupertinoActivityIndicator(
                color: color ?? AppColors.darkGreen,
                radius: iosRadius ?? 17,
              ),
            ),
          )
        : SizedBox(
            width: size ?? MediaQuery.of(context).size.width,
            height: size ?? MediaQuery.of(context).size.height,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: androidRadius!,
                valueColor: AlwaysStoppedAnimation<Color>(
                  color ?? AppColors.darkGreen,
                ),
              ),
            ),
          );
  }
}
