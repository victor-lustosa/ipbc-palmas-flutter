import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class TabButtonsWidget extends StatelessWidget {

  const TabButtonsWidget({super.key, required this.label, required this.action});
  final String label;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all<TextStyle?>(
          AppFonts.defaultFont(fontSize: 18),
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              return states.contains(MaterialState.hovered)
                  ? AppColors.darkGreen
                  : AppColors.grey6; // Defer to the widget's default.
            }),
        overlayColor: MaterialStateProperty.all<Color>(Colors.white),
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.white),
      ),
      onPressed: action,
      child: Text(label),
    );
  }
}
