/*
import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({
    Key? key,
    this.action,
    this.overlayColor,
    required this.child,
    this.foregroundColor,
    this.textStyle,
    this.shadowColor,
    this.backgroundColor,
    this.elevation,
    this.padding,
    this.sideColor,
    this.sideHoveredColor,
    this.foregroundHoveredColor
  }) : super(key: key);
  final Color? overlayColor;
  final Color? sideColor;
  final Color? sideHoveredColor;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? foregroundColor;
  final Color? foregroundHoveredColor;
  final TextStyle? textStyle;
  final Color? shadowColor;
  final double? elevation;
  final Color? backgroundColor;
  final VoidCallback? action;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          padding: padding == null
              ? null
              : MaterialStateProperty.all<EdgeInsetsGeometry>(padding!),
          elevation: elevation == null
              ? null
              : MaterialStateProperty.all<double>(elevation!),
          overlayColor: overlayColor == null
              ? null
              : MaterialStateProperty.all<Color>(overlayColor!),
          foregroundColor: foregroundColor == null && foregroundHoveredColor == null
              ? null
              : MaterialStateProperty.resolveWith((Set<MaterialState> states) {
            return states.isHovered
                ? foregroundHoveredColor!
                : foregroundColor!;
          }),
          shadowColor: shadowColor == null
              ? null
              : MaterialStateProperty.all<Color>(shadowColor!),
          backgroundColor: backgroundColor == null
              ? null
              : MaterialStateProperty.all<Color>(backgroundColor!),
          textStyle: MaterialStateProperty.all<TextStyle?>(
            textStyle ?? AppFonts.defaultFont(),
          ),
        ),
        onPressed: action,
        child: child,
    );
  }
}
*/
