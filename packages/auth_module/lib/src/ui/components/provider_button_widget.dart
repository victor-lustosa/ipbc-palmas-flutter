import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class ProviderButtonWidget extends StatefulWidget {
  const ProviderButtonWidget({
    super.key,
    required this.isPressed,
    required this.action,
    this.icon,
    this.label, this.size,
  });

  final ValueNotifier<bool> isPressed;
  final void Function() action;
  final String? icon;
  final String? label;
  final double? size;

  @override
  State<ProviderButtonWidget> createState() => _ProviderButtonWidgetState();
}

class _ProviderButtonWidgetState extends State<ProviderButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return LoadingButtonWidget(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      loadingIndicatorColor: AppColors.darkGreen,
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 25),
      loadingWidth: 55,
      textStyle: AppFonts.defaultFont(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      overlayColor: Colors.transparent,
      foregroundColor: AppColors.grey10,
      backgroundColor: AppColors.white,
      disableColor: AppColors.white,
      isPressed: widget.isPressed,
      action: widget.action,
      isValid: !widget.isPressed.value,
      child: AnimatedOpacity(
        opacity: widget.isPressed.value ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 400),
        curve: const Interval(0.5, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: !widget.isPressed.value,
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                child: Image.asset(
                  widget.icon ?? AppIcons.googleIcon,
                  width: widget.size ?? 30,
                  height: widget.size ?? 30,
                ),
              ),
            ),
            Visibility(
              visible: !widget.isPressed.value,
              child: Flexible(
                child: Text(widget.label ?? "Continuar com o Google"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
