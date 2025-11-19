import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HideIconWidget extends StatelessWidget {
  const HideIconWidget({super.key, required this.isObscure,required this.action});

  final ValueNotifier<bool> isObscure;
  final VoidCallback action;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isObscure,
        builder: (_, __, ___) {
        return IconButtonWidget(
          action: action,
          height: 24,
          color: AppColors.grey7,
          iOSIcon: isObscure.value ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
          androidIcon: isObscure.value
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
        );
      }
    );
  }
}
