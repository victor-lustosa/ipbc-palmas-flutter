import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class TabButtonsWidget extends StatelessWidget {
  const TabButtonsWidget({
    super.key,
    required this.label,
    required this.action,
  });

  final String label;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return TextButtonWidget(
      action: action,
      overlayColor: Colors.white,
      backgroundColor: AppColors.white,
      foregroundColor: AppColors.grey6,
      foregroundHoveredColor: AppColors.darkGreen,
      child: Text(label),
    );
  }
}
