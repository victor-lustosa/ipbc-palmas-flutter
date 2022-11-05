import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppFonts {
  static TextStyle? subtitle = GoogleFonts.inter(fontSize: 15, color: Colors.black45);
  static TextStyle? title = GoogleFonts.inter(color: AppColors.darkGreen, fontSize: 16,);
  static TextStyle? carouselWhite = GoogleFonts.inter(color: AppColors.black, fontSize: 25);
  static TextStyle? carouselGreen = GoogleFonts.inter(color: AppColors.white, fontSize: 25);
  static TextStyle? body = GoogleFonts.inter(color: AppColors.darkGreen, fontSize: 18);
  static TextStyle? lyricTile = GoogleFonts.inter(color: Colors.black, fontSize: 16.5);
  static TextStyle? h2 = GoogleFonts.inter(color: AppColors.black, fontSize: 24);
}
