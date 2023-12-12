import 'package:flutter/material.dart';

import '../../../design_system.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    Key? key,
    this.action,
    this.overlayColor,
    this.child,
    this.foregroundColor,
    this.textStyle,
    this.shadowColor,
    this.backgroundColor,
    this.shape,
    this.elevation,
    this.fixedSize,
    this.padding,
  }) : super(key: key);
  final Color? overlayColor;
  final Widget? child;
  final Color? foregroundColor;
  final TextStyle? textStyle;
  final Color? shadowColor;
  final double? elevation;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final VoidCallback? action;
  final OutlinedBorder? shape;
  final Size? fixedSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          fixedSize: fixedSize == null ? null : MaterialStateProperty.all<Size>(fixedSize!),
          elevation: elevation == null
              ? null
              : MaterialStateProperty.all<double>(elevation!),
          padding: padding == null
              ? null
              : MaterialStateProperty.all<EdgeInsets>(padding!),
          overlayColor: overlayColor == null
              ? null
              : MaterialStateProperty.all<Color>(overlayColor!),
          foregroundColor:foregroundColor == null
              ? null
              : MaterialStateProperty.all<Color>(foregroundColor!),
          shadowColor: shadowColor == null
              ? null
              : MaterialStateProperty.all<Color>(shadowColor!),
          backgroundColor: backgroundColor == null
              ? null
              : MaterialStateProperty.all<Color>(backgroundColor!),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            shape ?? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
          ),
          textStyle: MaterialStateProperty.all<TextStyle?>(
            textStyle ??
                AppFonts.defaultFont(
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkGreen
                ),
          ),
        ),
        onPressed: action,
        child: child,
    );
  }
}
