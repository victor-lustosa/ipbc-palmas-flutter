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
  static TextStyle? defaultFont({Color? color, double? fontSize, FontWeight? fontWeight, Color? decorationColor, TextDecoration? decoration, double? height}) {
    return GoogleFonts.inter(
      height: height,
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
  //web
  static const String announce = 'assets/icons/announce.png';
  static const String appleIcon = 'assets/icons/apple_icon.png';
  static const String playIcon = 'assets/icons/play_icon.png';
  static const String darkGreenCallIcon = 'assets/icons/call_icon_dark_green.png';
  static const String callIcon = 'assets/icons/call_icon.png';
  static const String arrowBackDarkGreen = 'assets/icons/arrow_back.png';
  static const String arrowForwardDarkGreen = 'assets/icons/arrow_forward.png';
  static const String greenArrowIcon = 'assets/icons/green_arrow_icon.png';
  static const String arrowIconDarkGreen = 'assets/icons/arrow_icon_dark_green.png';
  static const String book = 'assets/icons/book.png';
  static const String churchLocationIcon = 'assets/icons/church_location_icon.png';
  static const String volunteerActivismCube = 'assets/icons/volunteer_activism.png';

  //mobile
  static const String lyrics = 'assets/icons/lyrics.svg';
  static const String logo = 'assets/icons/logo.svg';
  static const String iosArrowBack = 'assets/icons/arrow_back_ios_new.svg';
  static const String home = 'assets/icons/home.svg';
  static const String volunteerActivism = 'assets/icons/volunteer_activism.svg';
  static const String accountCircle = 'assets/icons/account_circle.svg';

  static final sideBarIconsList = [
    'assets/icons/privacy_tip.svg',
    lyrics,
    'assets/icons/event.svg',
    'assets/icons/play_circle.svg',
    'assets/icons/book.svg',
    volunteerActivism,
    'assets/icons/group.svg',
  ];
}

class AppImages {
  //web
  static const String bannerStore = 'assets/images/banner_store.png';
  static const String churchLocation = 'assets/images/church_location.png';
  static const String hero = 'assets/images/hero.png';

  static const String saturdayServiceLg = 'assets/images/saturday_service_lg.png';
  static const String saturdayServiceMd = 'assets/images/saturday_service_md.png';
  static const String saturdayServiceSm = 'assets/images/saturday_service_sm.png';

  static const String sundayEveningServiceLg = 'assets/images/sunday_evening_service_lg.png';
  static const String sundayEveningServiceMd = 'assets/images/sunday_evening_service_md.png';
  static const String sundayEveningServiceSm = 'assets/images/sunday_evening_service_sm.png';

  static const String sundayMorningServiceLg = 'assets/images/sunday_morning_service_lg.png';
  static const String sundayMorningServiceMd = 'assets/images/sunday_morning_service_md.png';
  static const String sundayMorningServiceSm = 'assets/images/sunday_morning_service_sm.png';

  static const String littleGroupLg = 'assets/images/little_group_lg.png';
  static const String littleGroupMd = 'assets/images/little_group_md.png';
  static const String littleGroupSm = 'assets/images/little_group_sm.png';

  static const String footerLogo = 'assets/images/footer_logo.png';

  //mobile
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
