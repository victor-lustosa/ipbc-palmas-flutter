import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppFonts {
  static TextStyle? defaultFont({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    Color? decorationColor,
    TextDecoration? decoration,
    double? height,
  }) {
    return GoogleFonts.inter(
        height: height,
        color: color ?? AppColors.black,
        fontWeight: fontWeight ?? FontWeight.w400,
        fontSize: fontSize ?? 18,
        decorationColor: decorationColor,
        decoration: decoration);
  }

  static TextStyle? searchField = GoogleFonts.inter(
    decorationThickness: 0,
    color: AppColors.grey5,
    fontWeight: FontWeight.w200,
    fontSize: 12.5,
  );
  static TextStyle? largeTitle = GoogleFonts.inter(
    fontSize: 34,
    color: const Color(0xFF444446),
  );

  static TextStyle? title1 = GoogleFonts.inter(
    fontSize: 28,
    color: AppColors.black,
  );

  static TextStyle? title2 = GoogleFonts.inter(
    fontSize: 22,
    color: AppColors.black,
  );

  static TextStyle? title3(
      {Color? color, double? fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
      color: color ?? AppColors.black,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: fontSize ?? 20,
    );
  }

  static TextStyle? headline(
      {Color? color, double? fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
      color: color ?? AppColors.black,
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: fontSize ?? 17,
    );
  }

  static TextStyle? body(
      {Color? color, double? fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
      color: color ?? AppColors.black,
      fontWeight: fontWeight,
      fontSize: fontSize ?? 17,
    );
  }

  static TextStyle? link = GoogleFonts.inter(
    color: AppColors.white,
    fontWeight: FontWeight.w500,
    fontSize: 29,
  );

  static TextStyle? subhead(
      {Color? color, required double fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
      color: color ?? AppColors.white,
      fontWeight: fontWeight,
      fontSize: fontSize,
    );
  }

  static TextStyle? description(
      {Color? color, double? fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
      color: color ?? AppColors.white,
      fontWeight: fontWeight,
      fontSize: fontSize ?? 13,
    );
  }

  static TextStyle? bodyPlaceholder = GoogleFonts.inter(
    color: AppColors.grey5,
    fontWeight: FontWeight.w200,
    fontSize: 12.5,
  );

  static TextStyle? copyright(
      {Color? color, required double fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
      color: color ?? AppColors.grey5,
      fontWeight: fontWeight ?? FontWeight.w300,
      fontSize: fontSize,
    );
  }
}
