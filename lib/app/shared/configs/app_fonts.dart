import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppFonts {
  static TextStyle? subtitle = GoogleFonts.inter(
    fontSize: 15,
    color: Colors.black45,
  );
  static TextStyle? title = GoogleFonts.inter(
    color: AppColors.darkGreen,
    fontSize: 16,
  );
  static TextStyle? carouselWhite = GoogleFonts.inter(
    color: AppColors.black,
    fontSize: 20,
  );
  static TextStyle? carouselGreen = GoogleFonts.inter(
    color: AppColors.white,
    fontSize: 29,
  );
  static TextStyle? titleTile = GoogleFonts.inter(
    fontWeight: FontWeight.w500,
    color: const Color(0xFF444446),
    fontSize: 15,
  );
  static TextStyle? subtitleTile = GoogleFonts.inter(
    color: const Color(0xFF444446),
    fontSize: 13,
  );
  static TextStyle? titleDrawer = GoogleFonts.inter(
    color: AppColors.darkGreen,
    fontSize: 26.3,
  );
  static TextStyle? bodyDrawer = GoogleFonts.inter(
    color: Colors.black,
    fontSize: 16.7,
  );
  static TextStyle? lyricTile = GoogleFonts.inter(
    color: Colors.black,
    fontSize: 16.5,
  );
  static TextStyle? titleLyricView = GoogleFonts.inter(
    color: const Color(0xFF363638),
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );
  static TextStyle? headline = GoogleFonts.inter(
    color: const Color(0xFF444446),
    fontWeight: FontWeight.w500,
    fontSize: 17,
  );
  static TextStyle? h2 = GoogleFonts.inter(
    color: AppColors.black,
    fontSize: 25,
  );
  static TextStyle? bodyPlaceholder = GoogleFonts.inter(
    color: const Color(0xFFAEAEB2),
    fontWeight: FontWeight.w200,
    fontSize: 12.5,
  );
}
