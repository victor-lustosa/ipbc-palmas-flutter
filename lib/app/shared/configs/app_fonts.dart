import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppFonts {
  static TextStyle? subtitle =
      GoogleFonts.inter(fontSize: 13, color: Colors.black45);
  static TextStyle? title = GoogleFonts.inter(
    color: AppColors.darkGreen,
    fontSize: 16,
  );
  static TextStyle? body =
      GoogleFonts.inter(color: AppColors.darkGreen, fontSize: 18);

  static TextStyle? h2 =
      GoogleFonts.inter(color: AppColors.black, fontSize: 24);
}
