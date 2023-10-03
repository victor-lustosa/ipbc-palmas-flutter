import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class AppStoresWidget extends StatefulWidget {
  const AppStoresWidget({super.key});

  @override
  State<AppStoresWidget> createState() => _AppStoresWidgetState();
}

class _AppStoresWidgetState extends State<AppStoresWidget> with LaunchUrlMixin {
  late double width;
  Future<void>? _appStoreLink;
  Future<void>? _playStoreLink;

  final Uri appStoreLink = Uri(
      scheme: 'https',
      host: 'play.google.com',
      path: 'store/apps/details',
      queryParameters: {'id': 'com.ipbc.ipbc_palmas'});

  final Uri playStoreLink = Uri(
      scheme: 'https',
      host: 'play.google.com',
      path: 'store/apps/details',
      queryParameters: {'id': 'com.ipbc.ipbc_palmas'});

  @override
  Widget build(BuildContext context) {
    width = context.mediaQuery.size.width;
    if (width > 1200) {
      return web();
    } else if (width > 800) {
      return tablet();
    } else {
      return mobile();
    }
  }

  web() => Container(
        height: 734,
        width: width,
        decoration: const BoxDecoration(color: AppColors.darkGreen),
        child: Container(
          margin: const EdgeInsets.only(left: 120, top: 100),
          child: Stack(
            children: [
              Positioned(
                left: 170,
                top: 15,
                child: SizedBox(
                  width: width,
                  height: 684.81,
                  child: const Image(
                    image: AssetImage(AppImages.bannerStore),
                  ),
                ),
              ),
              Positioned(
                child: SizedBox(
                  width: 571,
                  height: 253,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 23),
                        child: title(fontSize: 46),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 40),
                        child: subtitle(textAlign: TextAlign.left),
                      ),
                      Row(
                        children: [
                          appButton(),
                          Container(
                            margin: const EdgeInsets.only(left: 24),
                            child: playButton(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  tablet() => Container(
        height: 780,
        width: width,
        decoration: const BoxDecoration(color: AppColors.darkGreen),
        child: Container(
          margin: const EdgeInsets.only(top: 80),
          child: Stack(
            children: [
              Positioned(
                top: 200,
                right: 1,
                child: SizedBox(
                  width: width,
                  height: 684.81,
                  child: const Image(
                    image: AssetImage(AppImages.bannerStore),
                  ),
                ),
              ),
              Positioned(
                left: 120,
                child: SizedBox(
                  width: 571,
                  height: 253,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 23),
                        child: title(fontSize: 46),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 40),
                        child: subtitle(
                          textAlign:
                              width > 480 ? TextAlign.left : TextAlign.center,
                        ),
                      ),
                      Row(
                        children: [
                          appButton(),
                          Container(
                            margin: const EdgeInsets.only(left: 24),
                            child: playButton(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  mobile() => Container(
        height: 780,
        width: width,
        decoration: const BoxDecoration(color: AppColors.darkGreen),
        child: Container(
          margin: const EdgeInsets.only(top: 60),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                child: SizedBox(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 23),
                        child: title(fontSize: 32),
                      ),
                      Container(
                        width: 400,
                        margin: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 40,
                        ),
                        child: subtitle(textAlign: TextAlign.center),
                      ),
                      appButton(),
                      Container(
                        margin: const EdgeInsets.only(top: 24),
                        child: playButton(),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 420,
                child: SizedBox(
                  width: width,
                  child: const Image(
                    image: AssetImage(AppImages.bannerStore),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  title({required double fontSize}) => Text(
        'Baixe o IPBC App',
        style: AppFonts.defaultFont(
          fontSize: fontSize,
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
      );

  subtitle({required TextAlign textAlign}) => Text(
        textAlign: textAlign,
        'Acompanhe a liturgia dos cultos, as letras das músicas cantadas e em breve, comunicações, eventos e mensagens pregadas.',
        style: AppFonts.defaultFont(
          height: 1.5,
          color: AppColors.white,
        ),
      );

  playButton() => StoreButton(
        iconPath: AppIcons.playIcon,
        labelStore: 'Baixe na PlayStore',
        onPressed: () {
          _playStoreLink = launchInBrowser(playStoreLink);
        },
      );

  appButton() => StoreButton(
        iconPath: AppIcons.appleIcon,
        labelStore: 'Baixe na App Store',
        onPressed: () {
          //   _appStoreLink = launchInBrowser(appStoreLink);
        },
      );
}

class StoreButton extends StatelessWidget {
  const StoreButton(
      {super.key,
      required this.labelStore,
      required this.iconPath,
      required this.onPressed});

  final String labelStore;
  final String iconPath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 272,
      decoration: BoxDecoration(
        color: AppColors.grey12,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 32,
              height: 32,
              child: Image.asset(iconPath),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16),
              child: Text(
                labelStore,
                style: AppFonts.defaultFont(
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
