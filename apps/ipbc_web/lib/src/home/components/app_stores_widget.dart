import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class AppStoresWidget extends StatefulWidget {
  const AppStoresWidget({super.key});

  @override
  State<AppStoresWidget> createState() => _AppStoresWidgetState();
}

class _AppStoresWidgetState extends State<AppStoresWidget> with LaunchUrlMixin {
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
    if (MediaQuery.of(context).size.width > 1200) {
      return web();
    } else if (MediaQuery.of(context).size.width > 800) {
      return tablet();
    } else {
      return AppStoresMobile(
        title: title(fontSize: 32),
        subtitle: subtitle(),
        playButton: playButton(),
        appButton: appButton(),
      );
    }
  }

  web() => Container(
        height: 734,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: Color(0xff005b40)),
        child: Container(
          margin: const EdgeInsets.only(left: 120, top: 100),
          child: Stack(
            children: [
              Positioned(
                left: 170,
                top: 15,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
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
                        child: subtitle(),
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
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: Color(0xff005b40)),
        child: Container(
          margin: const EdgeInsets.only(top: 80),
          child: Stack(
            children: [
              Positioned(
                top: 200,
                right: 1,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
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
                        child: subtitle(),
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

  title({required double fontSize}) => Text(
        'Baixe o IPBC App',
        style: AppFonts.defaultFont(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: const Color(0xffffffff),
        ),
      );

  subtitle() => Text(
    textAlign:TextAlign.center,
        'Acompanhe a liturgia dos cultos, as letras das músicas cantadas e em breve, comunicações, eventos e mensagens pregadas.',
        style: AppFonts.defaultFont(
          fontSize: 18,
          height: 1.5,
          fontWeight: FontWeight.w400,
          color: const Color(0xffffffff),
        ),
      );

  playButton() => StoreButton(
        labelStore: 'Baixe na PlayStore',
        iconPath: AppIcons.playIcon,
        onPressed: () {
          _playStoreLink = launchInBrowser(playStoreLink);
        },
      );

  appButton() => StoreButton(
        labelStore: 'Baixe na App Store',
        iconPath: AppIcons.appleIcon,
        onPressed: () {
          //   _appStoreLink = launchInBrowser(appStoreLink);
        },
      );
}

class AppStoresMobile extends StatelessWidget {
  const AppStoresMobile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.appButton,
      required this.playButton});
  final dynamic title;
  final dynamic subtitle;
  final dynamic appButton;
  final dynamic playButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 780,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Color(0xff005b40)),
      child: Container(
        margin: const EdgeInsets.only(left: 0, top: 60),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: SizedBox(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 23),
                      child: title,
                    ),
                    Container(
                      width: 400,
                      margin: const EdgeInsets.only(bottom: 40),
                      child: subtitle,
                    ),
                    appButton,
                    Container(
                        margin: const EdgeInsets.only(top: 24),
                        child: playButton,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 420,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Image(
                  image: AssetImage(AppImages.bannerStore),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
        color: const Color(0xff242426),
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
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xffffffff),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
