import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:core_module/core_module.dart';

class HideIconWidget extends StatelessWidget {
  const HideIconWidget({
    super.key,
    required this.isObscure,
    required this.suffixAction,
  });
  final bool isObscure;
  final VoidCallback suffixAction;
  @override
  Widget build(BuildContext context) {
    return isObscure
        ? IconButtonWidget(
          action: suffixAction,
          size: 24,
          color: AppColors.grey7,
          iOSIcon: CupertinoIcons.eye_slash,
          androidIcon: Icons.visibility_off_outlined,
        )
        : IconButtonWidget(
          action: suffixAction,
          size: 24,
          color: AppColors.grey7,
          iOSIcon: CupertinoIcons.eye,
          androidIcon: Icons.visibility_outlined,
        );
  }
}
