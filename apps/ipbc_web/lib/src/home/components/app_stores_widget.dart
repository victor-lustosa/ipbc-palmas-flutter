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
    return Container(
      height: 734,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Color(0xff005b40)),
      child: Container(
        margin: const EdgeInsets.only(left: 120, top: 100),
        child: Stack(
          children: [
            Positioned(
              left: 280.341003418,
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
                      child: Text(
                        'Baixe o IPBC App',
                        style: AppFonts.defaultFont(
                          fontSize: 46,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 40),
                      child: Text(
                        'Acompanhe a liturgia dos cultos, as letras das músicas cantadas e em breve, comunicações, eventos e mensagens pregadas.',
                        style: AppFonts.defaultFont(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        storeButton(
                          'Baixe na App Store',
                          AppIcons.appleIcon,
                          () {
                            //   _appStoreLink = launchInBrowser(appStoreLink);
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 24),
                          child: storeButton(
                            'Baixe na PlayStore',
                            AppIcons.playIcon,
                            () {
                              _playStoreLink = launchInBrowser(playStoreLink);
                            },
                          ),
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
  }

  Widget storeButton(String labelStore, String iconPath, VoidCallback onPressed) =>
      Container(
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
