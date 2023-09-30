import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> with LaunchUrlMixin {
  Future<void>? _locationLink;
  late double vWidth;
  bool isHovered = false;
  final Uri locationLink = Uri(
    scheme: 'https',
    host: 'goo.gl',
    path: 'maps/p25aM3t4Azo23URo7',
  );

  @override
  Widget build(BuildContext context) {
    vWidth = context.mediaQuery.size.width;
    if (vWidth > 1200) {
      return web();
    } else if (vWidth > 640) {
      return tablet();
    } else {
      return mobile();
    }
  }

  web() => Container(
        height: 600,
        width: vWidth,
        margin: const EdgeInsets.only(top: 100),
        decoration: const BoxDecoration(color: AppColors.grey0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20),
              width: 1200,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: imageShadow(),
                    child: locationImage(width: 573.26),
                  ),
                  Container(
                    height: 273,
                    margin: const EdgeInsets.only(right: 69.74),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title(fontSize: 46),
                        subtitle(textAlign: TextAlign.start),
                        address(width: 480),
                        locationButton(width: 215, height: 49),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  tablet() => Container(
        height: 880,
        width: vWidth,
        margin: const EdgeInsets.only(top: 100),
        decoration: const BoxDecoration(color: AppColors.grey0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: imageShadow(),
              child: ClipRRect(
                child: locationImage(width: 573.26),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Container(
              height: 273,
              margin: const EdgeInsets.only(left: 80, right: 69.74, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  title(fontSize: 46),
                  subtitle(textAlign: TextAlign.start),
                  address(width: 480),
                  locationButton(width: 215, height: 49),
                ],
              ),
            ),
          ],
        ),
      );

  mobile() => Container(
        height: 750,
        width: vWidth,
        margin: const EdgeInsets.only(top: 60),
        decoration: const BoxDecoration(color: AppColors.grey0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: imageShadow(),
              child: ClipRRect(
                child: locationImage(),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 24, right: 24, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  title(fontSize: 32),
                  subtitle(textAlign: TextAlign.center,width: 360),
                  address(width: 360),
                  locationButton(width: 342, height: 49),
                ],
              ),
            ),
          ],
        ),
      );

  locationImage({ double? width}) => Image(
        width: width,
        fit: BoxFit.cover,
        image: const AssetImage(
          AppImages.churchLocation,
        ),
      );

  title({required double fontSize}) => Container(
        margin: const EdgeInsets.only(bottom: 23),
        child: Text(
          'Localização',
          style: AppFonts.defaultFont(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: AppColors.grey12,
          ),
        ),
      );

  subtitle({required TextAlign textAlign, double? width}) => Container(
    width: width,
        margin: const EdgeInsets.only(bottom: 24),
        child: Text(
          textAlign: textAlign,
          'A igreja fica localizada na quadra central em Palmas/TO.',
          style: AppFonts.defaultFont(
            height: 1.5,
            color: const Color(0xff545456),
          ),
        ),
      );

  address({double? width}) => SizedBox(
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16, top: 7),
              child: Image.asset(
                AppIcons.churchLocationIcon,
                width: 24,
                height: 24,
              ),
            ),
            Flexible(
              child: Text(
                'Quadra Arse 23, Av.Ns 06, Ai 09 - Plano Diretor Sul, Palmas - TO',
                style: AppFonts.defaultFont(
                  height: 1.5,
                  color: const Color(0xff545456),
                ),
              ),
            ),
          ],
        ),
      );

  imageShadow() => BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 40,
            offset: Offset(4, 4),
            spreadRadius: 0,
          )
        ],
      );

  locationButton({
    required double width,
    required double height,
  }) =>
      Container(
        width: width,
        height: height,
        margin: const EdgeInsets.only(top: 40),
        child: OutlinedButtonWidget(
          state: (bool value) {
            Future.delayed(const Duration(milliseconds: 62), () async {
              setState(() {
                isHovered = value;
              });
            });
          },
          sideColor: AppColors.highlightGreen,
          sideHoveredColor: AppColors.darkGreen,
          foregroundColor: AppColors.highlightGreen,
          foregroundHoveredColor: AppColors.darkGreen,
          overlayColor: AppColors.grey0,
          action: () {
            _locationLink = launchInBrowser(locationLink);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Ver Localização'),
              Container(
                margin: const EdgeInsets.only(left: 16),
                child: Image.asset(
                  isHovered
                      ? AppIcons.arrowIconDarkGreen
                      : AppIcons.arrowIconHighlightGreen,
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
        ),
      );
}
