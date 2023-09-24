import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class OutlinedButtonWidget extends StatefulWidget {
  const OutlinedButtonWidget(
      {Key? key,
      this.action,
      this.overlayColor,
      this.child,
      this.foregroundColor,
      this.textStyle,
      this.shadowColor,
      this.backgroundColor,
      this.shape,
      this.elevation,
      this.padding,
      this.sideColor,
      this.sideHoveredColor,
      required this.state,
      this.foregroundHoveredColor})
      : super(key: key);

  final Color? overlayColor;
  final Color? sideColor;
  final Color? sideHoveredColor;
  final Function(bool) state;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final Color? foregroundColor;
  final Color? foregroundHoveredColor;
  final TextStyle? textStyle;
  final Color? shadowColor;
  final double? elevation;
  final Color? backgroundColor;
  final VoidCallback? action;
  final OutlinedBorder? shape;

  @override
  State<OutlinedButtonWidget> createState() => _OutlinedButtonWidgetState();
}

class _OutlinedButtonWidgetState extends State<OutlinedButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        side: widget.sideColor == null && widget.sideHoveredColor == null
            ? null
            : MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                return states.isHovered
                    ? BorderSide(color: widget.sideHoveredColor!)
                    : BorderSide(color: widget.sideColor!);
              }),
        padding: widget.padding == null
            ? null
            : MaterialStateProperty.all<EdgeInsetsGeometry>(widget.padding!),
        elevation: widget.elevation == null
            ? null
            : MaterialStateProperty.all<double>(widget.elevation!),
        overlayColor: widget.overlayColor == null
            ? null
            : MaterialStateProperty.all<Color>(widget.overlayColor!),
        foregroundColor: widget.foregroundColor == null &&
                widget.foregroundHoveredColor == null
            ? null
            : MaterialStateProperty.resolveWith((Set<MaterialState> states) {
                Future.delayed(const Duration(milliseconds: 55), () async {
                    widget.state(states.isHovered);
                });

                return states.isHovered
                    ? widget.foregroundHoveredColor!
                    : widget.foregroundColor!;
              }),
        shadowColor: widget.shadowColor == null
            ? null
            : MaterialStateProperty.all<Color>(widget.shadowColor!),
        backgroundColor: widget.backgroundColor == null
            ? null
            : MaterialStateProperty.all<Color>(widget.backgroundColor!),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          widget.shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle?>(
          widget.textStyle ??
              AppFonts.defaultFont(
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      onPressed: widget.action,
      child: widget.child,
    );
  }
}
