import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'configs/app_colors.dart';

final lightTheme = ThemeData(
  splashColor: Colors.transparent,
  brightness: Brightness.light,
  highlightColor: Colors.transparent,
  scaffoldBackgroundColor: AppColors.white,
  primaryColor: AppColors.white,
);
/*
setDarkAppBar() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
  );
}

setLightAppBar() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
  );
}
*/