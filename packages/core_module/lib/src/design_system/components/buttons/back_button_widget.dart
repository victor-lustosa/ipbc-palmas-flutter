import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BackButtonWidget extends StatelessWidget {
  final void Function()? action;
  final Color? color;
  final double? size;

  const BackButtonWidget({
    super.key,
    required this.action,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return IconButtonWidget(
      size: size ?? 30,
      color: color ?? AppColors.darkGreen,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      iOSIcon: CupertinoIcons.chevron_back,
      androidIcon: Icons.arrow_back_rounded,
      action: action,
    );
  }
}
