import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  //primary
  static const Color darkGreen = Color.fromARGB(255, 0, 83, 58);

  //neutral
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey0 = Color(0xFFF3F3F3);
  static const Color grey1 = Color(0xFFEDEDED);
  static const Color grey2 = Color(0xFFE0E0E0);
  static const Color grey3 = Color(0xFFDADADA);
  static const Color grey4 = Color(0xFFC5C5C7);
  static const Color grey5 = Color(0xFFAEAEB2);
  static const Color grey6 = Color(0xFF8E8E93);
  static const Color grey7 = Color(0xFF7C7C80);
  static const Color grey8 = Color(0xFF545456);
  static const Color grey9 = Color(0xFF444446);
  static const Color grey10 = Color(0xFF363638);
  static const Color grey11 = Color.fromARGB(108, 238, 238, 238);
  static const Color grey12 = Color(0xFF242426);
  static const Color black = Color(0xFF171717);

  //secondary
  static const Color secondaryGreen = Color(0xFF00A876);
  static const Color highlightGreen = Color(0xFF00E8A2);
  static const Color timelineGuideTGreen = Color(0xFFCCDED9);
  static const Color badgeGreen = Color(0xFFE4F5F0);
  static const Color tooltipIcon = Color(0xFF171717);

//system colors ios
  static const Color confirmation = Color(0xFF34C759);
  static const Color delete = Color(0xFFFF3B30);
  static const Color warning = Color(0xFFFF9500);
  static const Color add = Color(0xFF007AFF);
  static const Color information = Color(0xFF30AAC7);
}

class AppFonts {
  static TextStyle? defaultFont({Color? color, double? fontSize, FontWeight? fontWeight, Color? decorationColor, TextDecoration? decoration}) {
    return GoogleFonts.inter(
      color: color ?? AppColors.black,
      fontWeight: fontWeight,
      fontSize: fontSize ?? 18,
      decorationColor: decorationColor,
      decoration: decoration
    );
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

class AppIcons {
  static const String lyrics = 'assets/icons/lyrics.svg';
  static const String logo = 'assets/icons/logo.svg';
  static const String callIcon = 'assets/icons/call.png';
  static const String arrowBack = 'assets/icons/arrow_back_ios_new.svg';
  static const String home = 'assets/icons/home.svg';
  static const String volunteerActivism = 'assets/icons/volunteer_activism.svg';
  static const String accountCircle = 'assets/icons/account_circle.svg';

  static final sideBarIconsList = [
    'assets/icons/privacy_tip.svg',
    'assets/icons/lyrics.svg',
    'assets/icons/event.svg',
    'assets/icons/play_circle.svg',
    'assets/icons/book.svg',
    'assets/icons/volunteer_activism.svg',
    'assets/icons/group.svg',
  ];
}

class AppImages {
  static const String vagalumeImage = 'assets/images/vagalume_image.png';
  static const String wifiIconImage = 'assets/images/wifi_icon.png';
  static const String noConnectionImage = 'assets/images/perm_scan_wifi.png';
  static const String logo = 'assets/images/logo.png';
  static final List<String> defaultCoversList = [
    'assets/images/default_cover_1.png',
    'assets/images/default_cover_2.png',
    'assets/images/default_cover_3.png',
    'assets/images/default_cover_4.png'
  ];
}
