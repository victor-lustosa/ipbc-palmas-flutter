import 'package:flutter/material.dart';

import 'configs/app_colors.dart';

final lightTheme = ThemeData(
  splashColor: Colors.transparent,
  brightness: Brightness.light,
  highlightColor: Colors.transparent,
  scaffoldBackgroundColor: AppColors.white,
  primaryColor: AppColors.white,
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: AppColors.hintInputForm,
    selectionColor: AppColors.hintInputForm.withAlpha(30),
    selectionHandleColor: AppColors.hintInputForm,
  ),
);
