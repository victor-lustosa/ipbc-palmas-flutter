import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class LoadingButtonWidget extends StatelessWidget {
  const LoadingButtonWidget({
    super.key,
    required this.isPressed,
    this.action,
    required this.isValid,
    this.marginBottom,
    this.marginTop,
    required this.label,
    this.loadingWidth,
  });

  final bool isPressed;
  final double? marginBottom;
  final double? marginTop;
  final double? loadingWidth;
  final bool isValid;
  final String label;
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.only(
        top: marginTop ?? 0,
        bottom: marginBottom ?? 0,
        left: 16,
        right: 16,
      ),
      width: isPressed ? (loadingWidth ?? 48) : context.sizeOf.width,
      height: 48,
      duration: const Duration(milliseconds: 750),
      curve: Curves.fastOutSlowIn,
      child: ButtonWidget(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        action: action,
        backgroundColor:
            isValid ? AppColors.darkGreen : AppColors.disableButton,
        shadowColor: AppColors.grey0,
        child:
            isPressed
                ? const LoadingWidget(
                  androidRadius: 2,
                  iosRadius: 11,
                  size: 20,
                  color: AppColors.white,
                )
                : Text(
                  label,
                  style: AppFonts.defaultFont(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
      ),
    );
  }
}
