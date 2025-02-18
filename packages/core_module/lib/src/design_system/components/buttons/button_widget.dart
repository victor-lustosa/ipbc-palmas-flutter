import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

enum AdaptiveButtonType { outlined, text, elevated }

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({
    super.key,
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
    this.adaptiveButtonType,
    this.sideColor,
    this.sideHoveredColor,
    this.state,
    this.foregroundHoveredColor,
  });

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
  final AdaptiveButtonType? adaptiveButtonType;
  final Color? sideColor;
  final Color? sideHoveredColor;
  final Function(bool)? state;
  final Color? foregroundHoveredColor;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  styleButton({
    required WidgetStateProperty<BorderSide?>? side,
    required WidgetStateProperty<Color?>? foregroundColor,
    required TextStyle? textStyle,
  }) => ButtonStyle(
    side: side,
    fixedSize:
        widget.fixedSize == null
            ? null
            : WidgetStateProperty.all<Size>(widget.fixedSize!),
    padding:
        widget.padding == null
            ? WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero)
            : WidgetStateProperty.all<EdgeInsets>(widget.padding!),
    elevation:
        widget.elevation == null
            ? null
            : WidgetStateProperty.all<double>(widget.elevation!),
    overlayColor:
        widget.overlayColor == null
            ? null
            : WidgetStateProperty.all<Color>(widget.overlayColor!),
    foregroundColor: foregroundColor,
    shadowColor:
        widget.shadowColor == null
            ? null
            : WidgetStateProperty.all<Color>(widget.shadowColor!),
    backgroundColor:
        widget.backgroundColor == null
            ? null
            : WidgetStateProperty.all<Color>(widget.backgroundColor!),
    textStyle: WidgetStateProperty.all<TextStyle?>(textStyle),
    shape: WidgetStateProperty.all<OutlinedBorder>(
      widget.shape ??
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
  );

  get sideStyle =>
      widget.sideColor == null && widget.sideHoveredColor == null
          ? null
          : WidgetStateProperty.resolveWith((Set<WidgetState> states) {
            return states.isHovered
                ? BorderSide(color: widget.sideColor!)
                : BorderSide(color: widget.sideColor!);
          });

  @override
  Widget build(BuildContext context) {
    switch (widget.adaptiveButtonType ?? AdaptiveButtonType.elevated) {
      case AdaptiveButtonType.text:
        return TextButton(
          style: styleButton(
            side: sideStyle,
            foregroundColor:
                widget.foregroundColor == null &&
                        widget.foregroundHoveredColor == null
                    ? null
                    : WidgetStateProperty.resolveWith((
                      Set<WidgetState> states,
                    ) {
                      return states.isHovered
                          ? widget.foregroundHoveredColor!
                          : widget.foregroundColor!;
                    }),
            textStyle: widget.textStyle ?? AppFonts.defaultFont(),
          ),
          onPressed: widget.action,
          child: widget.child!,
        );

      case AdaptiveButtonType.outlined:
        return OutlinedButton(
          style: styleButton(
            side: sideStyle,
            foregroundColor:
                widget.foregroundColor == null &&
                        widget.foregroundHoveredColor == null
                    ? null
                    : WidgetStateProperty.resolveWith((
                      Set<WidgetState> states,
                    ) {
                      if (widget.state != null) {
                        widget.state!(states.isPressed);
                      }
                      return states.isHovered
                          ? widget.foregroundColor!
                          : widget.foregroundColor!;
                    }),
            textStyle:
                widget.textStyle ??
                AppFonts.defaultFont(fontWeight: FontWeight.w500),
          ),
          onPressed: widget.action,
          child: widget.child,
        );

      case AdaptiveButtonType.elevated:
        return ElevatedButton(
          style: styleButton(
            side: sideStyle,
            textStyle:
                widget.textStyle ??
                AppFonts.defaultFont(
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkGreen,
                ),
            foregroundColor:
                widget.foregroundColor == null
                    ? null
                    : WidgetStateProperty.all<Color>(widget.foregroundColor!),
          ),
          onPressed: widget.action,
          child: widget.child,
        );
    }
  }
}
