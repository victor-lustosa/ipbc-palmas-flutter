import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class LoadingButtonWidget extends StatelessWidget {
  const LoadingButtonWidget({
    super.key,
    required this.isPressed,
    this.action,
    required this.isValid,
    this.width,
    this.height,
    this.shape,
    this.decoration,
    this.margin,
    this.label,
    this.loadingWidth,
    this.duration,
    this.backgroundColor,
    this.disableColor,
    this.loadingWidget,
    this.child,
    this.shadowColor,
    this.textStyle,
    this.foregroundColor,
    this.overlayColor,
    this.loadingIndicatorColor,
    this.adaptiveButtonType,
    this.foregroundHoveredColor,
    this.sideHoveredColor,
    this.sideColor,
    this.outlinedBorderWidth,
  });

  final ValueNotifier<bool> isPressed;
  final double? loadingWidth;
  final double? width;
  final Duration? duration;
  final double? height;
  final ValueNotifier<bool> isValid;
  final String? label;
  final Color? backgroundColor;
  final Color? disableColor;
  final Color? overlayColor;
  final Color? foregroundColor;
  final Color? foregroundHoveredColor;
  final Color? sideHoveredColor;
  final Color? sideColor;
  final Color? shadowColor;
  final BoxDecoration? decoration;
  final Widget? loadingWidget;
  final Color? loadingIndicatorColor;
  final Widget? child;
  final TextStyle? textStyle;
  final VoidCallback? action;
  final OutlinedBorder? shape;
  final EdgeInsetsGeometry? margin;
  final AdaptiveButtonType? adaptiveButtonType;
  final double? outlinedBorderWidth;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isPressed,
      builder: (context, isLoading, _) {
        return AnimatedContainer(
          decoration: decoration,
          margin:
              margin ??
              const EdgeInsets.only(top: 40, bottom: 24, left: 16, right: 16),
          width: isLoading
              ? (loadingWidth ?? context.sizeOf.width)
              : (width ?? context.sizeOf.width),
          height: height ?? 48,
          duration: duration ?? const Duration(milliseconds: 750),
          curve: Curves.fastOutSlowIn,
          child: ButtonWidget(
            adaptiveButtonType: adaptiveButtonType,
            overlayColor: overlayColor,
            sideColor: sideColor,
            sideHoveredColor: sideHoveredColor,
            foregroundHoveredColor: foregroundHoveredColor,
            style: textStyle,
            outlinedBorderWidth: outlinedBorderWidth,
            foregroundColor: foregroundColor ?? AppColors.white,
            shape:
                shape ??
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            action: isValid.value && !isLoading ? action : null,
            backgroundColor: isValid.value
                ? (backgroundColor ?? AppColors.darkGreen)
                : (disableColor ?? AppColors.disableButton),
            shadowColor: shadowColor ?? AppColors.grey0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedOpacity(
                  opacity: isLoading ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child:
                      loadingWidget ??
                      LoadingWidget(
                        androidRadius: 2,
                        iosRadius: 11,
                        size: 20,
                        color: loadingIndicatorColor ?? AppColors.white,
                      ),
                ),
                AnimatedOpacity(
                  opacity: isLoading ? 0.0 : 1.0,
                  duration: const Duration(milliseconds: 400),
                  curve: const Interval(0.5, 1.0),
                  child:
                      child ??
                      Text(
                        label ?? '',
                        style:
                            textStyle ??
                            AppFonts.defaultFont(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
