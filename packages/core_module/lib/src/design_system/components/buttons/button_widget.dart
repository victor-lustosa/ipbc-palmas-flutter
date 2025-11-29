import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

enum AdaptiveButtonType { outlined, text, elevated }

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    this.action,
    this.overlayColor,
    this.child,
    this.foregroundColor,
    this.style,
    this.shadowColor,
    this.backgroundColor,
    this.shape,
    this.elevation,
    this.fixedSize,
    this.padding,
    this.adaptiveButtonType,
    this.sideColor,
    this.sideHoveredColor,
    this.state,
    this.foregroundHoveredColor,
    this.outlinedBorderWidth,
    this.onHover,
  });

  final Color? overlayColor;
  final Widget? child;
  final Color? foregroundColor;
  final TextStyle? style;
  final Color? shadowColor;
  final double? elevation;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final VoidCallback? action;
  final OutlinedBorder? shape;
  final Size? fixedSize;
  final AdaptiveButtonType? adaptiveButtonType;
  final Color? sideColor;
  final Color? sideHoveredColor;
  final Function(bool)? state;
  final Color? foregroundHoveredColor;
  final double? outlinedBorderWidth;
  final void Function(bool)? onHover;

  WidgetStateProperty<BorderSide?>? get _sideStyle {
    if (sideColor == null && sideHoveredColor == null) return null;

    return WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      final isHovered = states.contains(WidgetState.hovered);

      final color = (isHovered && sideHoveredColor != null)
          ? sideHoveredColor!
          : sideColor ?? Colors.transparent;

      return BorderSide(
        color: color,
        width: outlinedBorderWidth ?? 1.0,
        strokeAlign: BorderSide.strokeAlignOutside,
      );
    });
  }

  WidgetStateProperty<Color?>? get _foregroundColorStyle {
    if (foregroundHoveredColor == null && foregroundColor == null) return null;

    return WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (state != null) {
        state!(states.contains(WidgetState.pressed));
      }

      final isHovered = states.contains(WidgetState.hovered);

      if (isHovered && foregroundHoveredColor != null) {
        return foregroundHoveredColor!;
      }

      return foregroundColor;
    });
  }

  ButtonStyle get _buildButtonStyle {
    return ButtonStyle(
      side: _sideStyle,
      textStyle: WidgetStateProperty.all(
        style ??
            AppFonts.defaultFont(
              fontWeight: FontWeight.w600,
            ),
      ),
      foregroundColor: _foregroundColorStyle,
      fixedSize: fixedSize != null ? WidgetStateProperty.all(fixedSize) : null,
      padding: padding != null
          ? WidgetStateProperty.all(padding)
          : WidgetStateProperty.all(EdgeInsets.zero),
      elevation: elevation != null ? WidgetStateProperty.all(elevation) : null,
      overlayColor: overlayColor != null
          ? WidgetStateProperty.all(overlayColor)
          : null,
      shadowColor: shadowColor != null
          ? WidgetStateProperty.all(shadowColor)
          : null,
      backgroundColor: backgroundColor != null
          ? WidgetStateProperty.all(backgroundColor)
          : null,
      shape: WidgetStateProperty.all(
        shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonChild = child ?? const SizedBox.shrink();

    switch (adaptiveButtonType ?? AdaptiveButtonType.elevated) {
      case AdaptiveButtonType.text:
        return TextButton(
          style: _buildButtonStyle,
          onHover: onHover,
          onPressed: action,
          child: buttonChild,
        );

      case AdaptiveButtonType.outlined:
        return OutlinedButton(
          style: _buildButtonStyle,
          onHover: onHover,
          onPressed: action,
          child: buttonChild,
        );

      case AdaptiveButtonType.elevated:
        return ElevatedButton(
          style: _buildButtonStyle,
          onHover: onHover,
          onPressed: action,
          child: buttonChild,
        );
    }
  }
}
