import 'package:core_module/core_module.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../view_models/home_view_model.dart';

class AboutServicesWidget extends StatefulWidget {
  const AboutServicesWidget({super.key});

  @override
  State<AboutServicesWidget> createState() => _AboutServicesWidgetState();
}

class _AboutServicesWidgetState extends State<AboutServicesWidget> {

  final List<ServicesEntity> servicesImagesLg = [
    ServicesModel.empty().copyWith(image: AppImages.sundayEveningServiceLg, title: 'Culto Solene'),
    ServicesModel.empty().copyWith(image: AppImages.saturdayServiceLg, title: 'Culto de Jovens'),
    ServicesModel.empty().copyWith(image: AppImages.sundayMorningServiceLg, title: 'Escola Bíblica Dominical'),
    ServicesModel.empty().copyWith(image: AppImages.littleGroupLg, title: 'Pequeno Grupo'),
  ];

  final List<ServicesEntity> servicesImagesMd = [
    ServicesModel.empty().copyWith(image: AppImages.sundayEveningServiceMd, title: 'Culto Solene',),
    ServicesModel.empty().copyWith(image: AppImages.saturdayServiceMd, title: 'Culto de Jovens'),
    ServicesModel.empty().copyWith(image: AppImages.sundayMorningServiceMd, title: 'Escola Bíblica Dominical'),
    ServicesModel.empty().copyWith(image: AppImages.littleGroupMd, title: 'Pequeno Grupo'),
  ];

  final List<ServicesEntity> servicesImagesSm = [
    ServicesModel.empty().copyWith(image: AppImages.sundayEveningServiceSm, title: 'Culto Solene',),
    ServicesModel.empty().copyWith(image: AppImages.saturdayServiceSm, title: 'Culto de Jovens'),
    ServicesModel.empty().copyWith(image: AppImages.sundayMorningServiceSm, title: 'Escola Bíblica Dominical'),
    ServicesModel.empty().copyWith(image: AppImages.littleGroupSm, title: 'Pequeno Grupo'),
  ];

  @override
  Widget build(BuildContext context) {
    if (context.mediaQuery.size.width > 1200) {
      return web();
    } else if (context.mediaQuery.size.width > 770) {
      return tablet();
    } else {
      return mobile();
    }
  }

  web() => Container(
        decoration: const BoxDecoration(color: Color(0xffffffff)),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                bottom: 79,
                top: 100,
              ),
              child: title(fontSize: 46),
            ),
            Container(
              height: 694,
              width: 963,
              margin: const EdgeInsets.only(bottom: 127),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  descriptionServices(
                      crossAxisAlignment: CrossAxisAlignment.start, width: 260),
                  verticalCards(),
                ],
              ),
            ),
          ],
        ),
      );

  tablet() => Container(
        decoration: const BoxDecoration(color: Color(0xffffffff)),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                bottom: 79,
                top: 100,
              ),
              child: title(fontSize: 46),
            ),
            Container(
              height: 694,
              width: 963,
              margin: const EdgeInsets.only(bottom: 127),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  descriptionServices(
                    width: 260,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  verticalCards(),
                ],
              ),
            ),
          ],
        ),
      );

  mobile() => Container(
        decoration: const BoxDecoration(color: Color(0xffffffff)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 40, top: 80),
              child: title(fontSize: 32),
            ),
            SizedBox(
              width: 580,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  descriptionServices(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      width: context.mediaQuery.size.width > 580
                          ? context.mediaQuery.size.width * 0.5
                          : 280),
                ],
              ),
            ),
            horizontalCards(),
          ],
        ),
      );

  descriptionServices(
          {CrossAxisAlignment? crossAxisAlignment,
          MainAxisAlignment? mainAxisAlignment,
          required double width}) =>
      Container(
        margin: const EdgeInsets.only(top: 10, left: 24),
        width: width,
        child: Column(
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          children: [
            cardService(
              'Culto Solene',
              'Domingo às 19h, na IPBC Palmas',
            ),
            cardService(
              'Culto de Jovens',
              'Sábado às 19h30 na IPBC Palmas',
            ),
            cardService(
              'Escola Bíblica Dominical',
              'Domingo às 9h, na IPBC Palmas',
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Text(
                'Pequenos Grupos',
                style: AppFonts.defaultFont(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff242426),
                ),
              ),
            ),
            RichText(
              text: TextSpan(
                style: AppFonts.defaultFont(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff545456),
                ),
                children: [
                  TextSpan(
                    text: 'Durante a semana em diversas localidades. ',
                    style: AppFonts.defaultFont(
                      fontSize: 18,
                      height: 1.5,
                      color: const Color(0xff545456),
                    ),
                  ),
                  TextSpan(
                    text: 'Entrar em contato para mais informações.',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => setState(
                            () {
                              Modular.get<HomeViewModel>()
                                  .scrollController
                                  .animateTo(
                                    duration: const Duration(
                                      milliseconds: 1500,
                                    ),
                                    curve: Curves.easeInOutQuint,
                                    3985,
                                  );
                            },
                          ),
                    style: AppFonts.defaultFont(
                      height: 1.5,
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                      color: const Color(0xff545456),
                      decorationColor: const Color(0xff545456),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  title({required double fontSize}) => Text(
        'Programação',
        style: AppFonts.defaultFont(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: const Color(0xff242426),
        ),
      );

  horizontalCards() => Container(
        margin: const EdgeInsets.only(bottom: 70, top: 50),
        child: CarouselWidget(
          padding: const EdgeInsets.only(
            left: 26,
            bottom: 16,
          ),
          fontStyle: AppFonts.defaultFont(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
          services: servicesImagesSm,
          width: context.mediaQuery.size.width < 602
              ? context.mediaQuery.size.width * .91
              : 550,
          height: context.mediaQuery.size.width < 602
              ? context.mediaQuery.size.width * .84
              : 510,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      );

  verticalCards() => SingleChildScrollView(
        child: SizedBox(
          width: context.mediaQuery.size.width > 1100 ? 618 : 457,
          height: 1333,
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 24);
            },
            scrollDirection: Axis.vertical,
            itemCount: servicesImagesLg.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) {
              return cardImage(
                context.mediaQuery.size.width > 1100
                    ? servicesImagesLg[index].image
                    : servicesImagesMd[index].image,
                context.mediaQuery.size.width > 1100
                    ? servicesImagesLg[index].image
                    : servicesImagesMd[index].image,
              );
            },
          ),
        ),
      );

  Widget cardImage(String image, String title) => Container(
        padding: const EdgeInsets.only(
          left: 16,
          top: 270,
          right: 16,
          bottom: 16,
        ),
        decoration: BoxDecoration(
          color: AppColors.grey4,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(image),
          ),
        ),
        child: Text(
          title,
          style: AppFonts.defaultFont(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: const Color(0xffffffff),
          ),
        ),
      );

  Widget cardService(String title, String subtitle) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Text(
              title,
              style: AppFonts.defaultFont(
                height: 1.5,
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: const Color(0xff242426),
              ),
            ),
          ),
          Text(
            subtitle,
            style: AppFonts.defaultFont(
              fontSize: 18,
              height: 1.5,
              fontWeight: FontWeight.w400,
              color: const Color(0xff545456),
            ),
          ),
          const SizedBox(height: 40),
        ],
      );
}
