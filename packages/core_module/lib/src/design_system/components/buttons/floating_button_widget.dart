import 'package:flutter/material.dart';

import '../../../../core_module.dart';

class FloatingButtonWidget extends StatelessWidget {
  const FloatingButtonWidget({
    super.key,
    required this.action,
    this.iconColor,
    this.icon,
    required this.backgroundColor,
    this.size,
    this.pngIcon,
    this.isPressed,
    this.isValid,
    this.duration,
    this.loadingIndicatorColor,
  });

  final Color? loadingIndicatorColor;
  final Duration? duration;
  final ValueNotifier<bool>? isPressed;
  final void Function()? action;
  final Color? iconColor;
  final Color backgroundColor;
  final IconData? icon;
  final String? pngIcon;
  final double? size;
  final bool? isValid;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isPressed ?? ValueNotifier(false),
      builder: (context, isLoading, _) {
        return AnimatedContainer(
          decoration: const BoxDecoration(shape: BoxShape.circle),
          curve: Curves.fastOutSlowIn,
          duration: duration ?? const Duration(milliseconds: 400),
          height: 56,
          width: 56,
          child: FloatingActionButton(
                  shape: const CircleBorder(),
                  elevation: 3,
                  highlightElevation: 1.8,
                  focusElevation: 1.8,
                  hoverElevation: 1.8,
                  onPressed: action,
                  backgroundColor: backgroundColor,
                  child: isLoading
                      ? LoadingWidget(
                    androidRadius: 2,
                    iosRadius: 11,
                    size: 20,
                    color: loadingIndicatorColor ?? AppColors.white,
                  )
                      : icon != null
                      ? Icon(size: size ?? 45, icon, color: iconColor)
                      : SizedBox(
                          height: size,
                          width: size,
                          child: Image.asset(pngIcon ?? ''),
                        ),
                ),
        );
      },
    );
  }
}
