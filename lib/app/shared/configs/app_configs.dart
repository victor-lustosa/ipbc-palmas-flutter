import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

class AppColors {
  static const Color lightBlue = Color(0xFF5D9CFB);
  static const Color lightRed = Color(0xFFD15858);
  static const Color lightGreen = Color(0xFF4EB798);
  static const Color timelinePrimary = Color(0xFF444446);
  static const Color timelineSecondary = Color(0xFF545456);
  static const Color timelineCircleGreen = Color(0xFF00A876);
  static const Color timelineGuideTGreen = Color.fromARGB(100, 163, 200, 189);
  static const Color tooltipGreen = Color(0xFF00E8A2);
  static const Color darkGreen = Color.fromARGB(255, 0, 83, 58);
  static const Color badgeGreen = Color(0xFFE4F5F0);
  static const Color white = Color(0xFFFFFFFF);
  static const Color darkBlue = Color(0xFF007AFF);
  static const Color black = Color(0xFF171717);
  static const Color darkGrey = Color(0xFF5F5F5F);
  static const Color lightGrey = Color(0xFFEBEBEB);
  static const Color grey = Color(0xFFA3A3A3);
  static const Color secondaryLightGrey = Color(0xFFF3F3F3);
  //buscar no github esse valor
  static const Color secondLightGrey = Color.fromARGB(255, 242, 242, 242);

  static const Color logoGrey = Color.fromARGB(108, 238, 238, 238);
}

class AppFonts {
  static TextStyle? subtitle = GoogleFonts.inter(
    fontSize: 15,
    color: const Color(0xFF444446),
  );
  static TextStyle? headHome = GoogleFonts.inter(
    fontSize: 24,
    color: AppColors.black,
  );
  static TextStyle? subHeadHome = GoogleFonts.inter(
    fontSize: Platform.isIOS ? 16 : 15,
    color: const Color(0xFF545456),
  );
  static TextStyle? title = GoogleFonts.inter(
    color: AppColors.darkGreen,
    fontSize: 16,
  );
  static TextStyle? timelineTitle = GoogleFonts.inter(
    color: AppColors.timelinePrimary,
    fontSize: 17,
  );
  static TextStyle? timelineAdditional = GoogleFonts.inter(
    color: AppColors.timelineSecondary,
    fontSize: 13,
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
    color: AppColors.white,
    fontSize: Platform.isIOS ? 19 : 18,
  );
  static TextStyle? lyricsTitleTile = GoogleFonts.inter(
    fontWeight: FontWeight.w500,
    color: const Color(0xFF444446),
    fontSize: 17,
  );

  static TextStyle? servicesTitleTile = GoogleFonts.inter(
    fontWeight: FontWeight.w600,
    color: const Color(0xFF444446),
    fontSize: 15,
  );
  static TextStyle? serviceSubtitleTile = GoogleFonts.inter(
    color: const Color(0xFF545456),
    fontSize: 13,
  );
  static TextStyle? subtitleTile = GoogleFonts.inter(
    color: const Color(0xFF444446),
    fontSize: 14,
  );
  static TextStyle? titleDrawer = GoogleFonts.inter(
    color: AppColors.darkGreen,
    fontSize: 26.3,
  );
  static TextStyle? bodyDrawer = GoogleFonts.inter(
    color: Colors.black,
    fontSize: 16.7,
  );
  static TextStyle? body2 = GoogleFonts.inter(
    color: Colors.black,
    fontWeight: FontWeight.w500,
    fontSize: 17,
  );
  static TextStyle? wifiLabel = GoogleFonts.inter(
    color: Colors.black,
    fontSize: 13,
  );
  static TextStyle? cnpjLabel = GoogleFonts.inter(
    color: Colors.black,
    fontWeight: FontWeight.w600,
    fontSize: 18,
  );
  static TextStyle? selectedBottomNav = GoogleFonts.inter(
    fontSize: 10.5,
  );
  static TextStyle? lyricTile = GoogleFonts.inter(
    color: const Color(0xFF363638),
    fontSize: 17,
  );
  static TextStyle? lyricTileReduced = GoogleFonts.inter(
    color: const Color(0xFF363638),
    fontSize: 15,
  );
  static TextStyle? titleLyricView = GoogleFonts.inter(
    color: const Color(0xFF363638),
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );
  static TextStyle? titleLyricsView = GoogleFonts.inter(
    color: const Color(0xFF363638),
    fontWeight: FontWeight.w500,
    fontSize: 23,
  );
  static TextStyle? title3 = GoogleFonts.inter(
    color: const Color(0xFF363638),
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );
  static TextStyle? titleNoConnection = GoogleFonts.inter(
    color: const Color(0xFF242426),
    fontWeight: FontWeight.w500,
    fontSize: 17,
  );
  static TextStyle? headline = GoogleFonts.inter(
    color: const Color(0xFF444446),
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  static TextStyle? checkConnectionLabel = GoogleFonts.inter(
    color: const Color(0xFF242426),
    fontSize: 15,
  );
  static TextStyle? checkConnectionButtonLabel = GoogleFonts.inter(
    color:  AppColors.white,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  static TextStyle? headlineServices = GoogleFonts.inter(
    color: AppColors.white,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  static TextStyle? liturgyBadge = GoogleFonts.inter(
    color: const Color(0xFF005B40),
    fontWeight: FontWeight.w400,
    fontSize: Platform.isIOS ? 13 : 13,
  );
  static TextStyle? headlineLyrics = GoogleFonts.inter(
    color: const Color(0xFF444446),
    fontWeight: FontWeight.w500,
    fontSize: 19,
  );
  static TextStyle? h2 = GoogleFonts.inter(
    color: const Color(0xFF444446),
    fontWeight: FontWeight.w500,
    fontSize: 21,
  );
  static TextStyle? h2Reduced = GoogleFonts.inter(
    color: const Color(0xFF444446),
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  static TextStyle? bodyPlaceholder = GoogleFonts.inter(
    color: const Color(0xFFAEAEB2),
    fontWeight: FontWeight.w200,
    fontSize: 12.5,
  );
  static TextStyle? copyright = GoogleFonts.inter(
    color: const Color(0xFFAEAEB2),
    fontWeight: FontWeight.w300,
    fontSize: 13,
  );
  static TextStyle? copyrightReduced = GoogleFonts.inter(
    color: const Color(0xFFAEAEB2),
    fontWeight: FontWeight.w300,
    fontSize: 12,
  );
  static TextStyle? learnMore = GoogleFonts.inter(
    color: AppColors.darkGreen,
    fontWeight: FontWeight.w300,
    fontSize: 13,
  );
  static TextStyle? logoVagalume = GoogleFonts.inter(
    color: AppColors.darkGreen,
    fontWeight: FontWeight.w400,
    fontSize: 13,
  );
}

class AppIcons {
  static const String lyricsIconName = 'assets/icons/lyrics.svg';
  static const String logo = 'assets/icons/logo.svg';
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
  static final servicesImagesList = [
    'assets/images/saturday_evening.png',
    'assets/images/sunday_morning.jpg',
    'assets/images/sunday_evening.png'
  ];
  static final List<String> defaultCoversList = [
    'assets/images/default_cover_1.png',
    'assets/images/default_cover_2.png',
    'assets/images/default_cover_3.png',
    'assets/images/default_cover_4.png'
  ];
}
