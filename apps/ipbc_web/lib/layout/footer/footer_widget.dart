import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class FooterWidget extends StatefulWidget {
  const FooterWidget({super.key});

  @override
  State<FooterWidget> createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  late double vWidth;
  @override
  Widget build(BuildContext context) {
    vWidth = context.mediaQuery.size.width;

    if (vWidth > 1200) {
      return web();
    } else if (vWidth > 770) {
      return tablet();
    } else {
      return mobile();
    }
  }

  web() => Container(
        decoration: const BoxDecoration(color: AppColors.grey12,),
        width: vWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 116,
                bottom: 154,
              ),
              width: 910,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  logo(),
                  SizedBox(
                    width: 600,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        location(crossAxisAlignment: CrossAxisAlignment.start),
                        contacts(crossAxisAlignment: CrossAxisAlignment.start),
                        services(crossAxisAlignment: CrossAxisAlignment.start),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            footer(margin: const EdgeInsets.only(bottom: 47))
          ],
        ),
      );

  tablet() => Container(
        decoration: const BoxDecoration(color: AppColors.grey12,),
        width: vWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 76, bottom: 56),
              child: logo(),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                location(width: vWidth * .3),
                contacts(width: vWidth * .3),
                services(width: vWidth * .3, margin:  const EdgeInsets.only(bottom: 138)),
              ],
            ),
            footer(margin: const EdgeInsets.only(bottom: 96))
          ],
        ),
      );

  mobile() => Container(
        decoration: const BoxDecoration(color: AppColors.grey12),
        width: vWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 80, bottom: 56),
              child: logo(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                location(width: 200),
                contacts(width: 200),
                services(width: 200, margin:  const EdgeInsets.only(bottom: 120)),
              ],
            ),
            footer(width: context.mediaQuery.size.width * 0.75, margin: const EdgeInsets.only(bottom: 80))
          ],
        ),
      );

  logo() => SizedBox(
        width: 99.34,
        child: Image.asset(
          AppImages.footerLogo,
        ),
      );

  contacts({double? width, CrossAxisAlignment? crossAxisAlignment}) =>
      Container(
        margin: const EdgeInsets.only(bottom: 32),
        width: width,
        child: Column(
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: titleInfo('Contatos'),
            ),
            subtitleInfo('Secretaria da Igreja'),
            Container(
              margin: const EdgeInsets.only(bottom: 8, top: 8),
              child: subtitleInfo('+55 (63) 3213-2775'),
            ),
            subtitleInfo('8h as 12h - 14h as 18h'),
          ],
        ),
      );

  location({double? width, CrossAxisAlignment? crossAxisAlignment}) => Container(
    margin: const EdgeInsets.only(bottom: 32),
        width: width,
        child: Column(
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: titleInfo('Localização'),
            ),
            subtitleInfo('Q. Arse 23, Av.Ns 06, Ai 09'),
            Container(
              margin: const EdgeInsets.only(bottom: 8, top: 8),
              child: subtitleInfo('CEP: 77020-544'),
            ),
            subtitleInfo('Palmas/TO'),
          ],
        ),
      );

  services({double? width, CrossAxisAlignment? crossAxisAlignment, EdgeInsetsGeometry? margin}) =>
      Container(
        margin: margin,
        //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        width: width,
        child: Column(
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: titleInfo('Cultos'),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: subtitleInfo('Domingo às 9h e 19h'),
            ),
            subtitleInfo('Sábado às 19h30')
          ],
        ),
      );

  footer({double? width, required EdgeInsetsGeometry margin}) => Center(
        child: Container(
          width: width,
         // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
          margin: margin,
          child: subtitleInfo(
            'Copyright © 2023 Igreja Presbiteriana Central em Palmas/TO',
            textAlign: TextAlign.center,
          ),
        ),
      );

  titleInfo(String text) => Text(
        text,
        style: AppFonts.defaultFont(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: AppColors.white,
        ),
      );

  subtitleInfo(String text, {TextAlign? textAlign}) => Text(
        text,
        textAlign: textAlign,
        style: AppFonts.defaultFont(
          fontSize: 14,
          color: const Color.fromRGBO(255, 255, 255, 0.80),
        ),
      );
}
