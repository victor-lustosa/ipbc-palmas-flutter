import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> with LaunchUrlMixin {
  Future<void>? _locationLink;

  final Uri locationLink = Uri(
    scheme: 'https',
    host: 'goo.gl',
    path: 'maps/p25aM3t4Azo23URo7',
  );

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width > 1200) {
      return web();
    } else if (MediaQuery.of(context).size.width > 640) {
      return tablet();
    } else {
      return mobile();
    }
  }

  web() => Container(
        height: 600,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 100),
        decoration: const BoxDecoration(color: Color(0xfff3f3f3)),
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x19000000),
                          blurRadius: 40,
                          offset: Offset(4, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
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
                        address(width: 437),
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
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 100),
        decoration: const BoxDecoration(color: Color(0xfff3f3f3)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 40,
                    offset: Offset(4, 4),
                    spreadRadius: 0,
                  )
                ],
              ),

              child: ClipRRect(
                child:  locationImage(width: 573.26),
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
                  address(width: 437),
                  locationButton( width: 215, height: 49),
                ],
              ),
            ),
          ],
        ),
      );

  mobile() => Container(
        height: 750,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(top: 60),
        decoration: const BoxDecoration(color: Color(0xfff3f3f3)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 40,
                    offset: Offset(4, 4),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: ClipRRect(
                child: locationImage(width: 445),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 80, right: 69.74, top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  title(fontSize: 32),
                  subtitle(textAlign: TextAlign.center),
                  address(width: MediaQuery.of(context).size.width * 0.65),
                  locationButton(width: 342, height: 49),
                ],
              ),
            ),
          ],
        ),
      );
  locationImage({required double width}) => Image(
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
            color: const Color(0xff242426),
          ),
        ),
      );

  subtitle({required TextAlign textAlign}) => Container(
        margin: const EdgeInsets.only(bottom: 24),
        child: Text(
          textAlign: textAlign,
          'A igreja fica localizada na quadra central em Palmas/TO.',
          style: AppFonts.defaultFont(
            height: 1.5,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: const Color(0xff545456),
          ),
        ),
      );

  address({required double width}) => SizedBox(
    width: width,
    child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16,top: 7),
              child: Image.asset(
                AppIcons.churchLocationIcon,
                width: 24,
                height: 24,
              ),
            ),
            SizedBox(
              width: width - 40,
              child: Text(
                'Quadra Arse 23, Av.Ns 06, Ai 09 - Plano Diretor Sul, Palmas - TO',
                style: AppFonts.defaultFont(
                  fontSize: 18,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff545456),
                ),
              ),
            ),
          ],
        ),
  );

  locationButton({required double width, required double height,}) => Container(
        width: width,
        height: height,
        margin: const EdgeInsets.only(top: 40),
        child: OutlinedButton(
          style: ButtonStyle(
            side: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              return states.contains(MaterialState.hovered)
                  ? const BorderSide(color: AppColors.darkGreen)
                  : const BorderSide(color: Color(0xCC005B40));
            }),
            foregroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
              return states.contains(MaterialState.hovered)
                  ? AppColors.darkGreen
                  : const Color(0xCC005B40);
            }),
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color(0xfff3f3f3),
            ),
            overlayColor: MaterialStateProperty.all<Color>(
              const Color(0xfff3f3f3),
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            textStyle: MaterialStateProperty.all<TextStyle?>(
              AppFonts.defaultFont(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          onPressed: () {
            _locationLink = launchInBrowser(locationLink);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Ver Localização'),
              Container(
                margin: const EdgeInsets.only(left: 16),
                child: Image.asset(
                  AppIcons.arrowIconDarkGreen,
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          ),
        ),
      );
}
