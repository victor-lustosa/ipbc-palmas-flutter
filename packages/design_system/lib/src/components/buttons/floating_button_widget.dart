import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class FloatingButtonWidget extends StatelessWidget {
  const FloatingButtonWidget({super.key, required this.action});

  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: 56,
      child: FloatingActionButton(
        shape: const CircleBorder(),
        elevation: 1.8,
        highlightElevation: 1.8,
        focusElevation: 1.8,
        hoverElevation: 1.8,
        onPressed: action,
        backgroundColor: AppColors.add,
        child: const Icon(
          size: 45,
          Icons.add_rounded,
          color: AppColors.white,
        ),
      ),
    );
  }
}
