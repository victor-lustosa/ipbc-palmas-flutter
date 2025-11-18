import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HideIconWidget extends StatelessWidget {
  const HideIconWidget({super.key, required this.isObscure});

  final ValueNotifier<bool> isObscure;

  @override
  Widget build(BuildContext context) {
    return IconButtonWidget(
      action: () {
        isObscure.value = !isObscure.value;
      },
      height: 24,
      color: AppColors.grey7,
      iOSIcon: isObscure.value ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
      androidIcon: isObscure.value
          ? Icons.visibility_off_outlined
          : Icons.visibility_outlined,
    );
  }
}
