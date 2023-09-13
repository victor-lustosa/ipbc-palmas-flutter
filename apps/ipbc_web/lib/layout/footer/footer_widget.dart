import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class FooterWidget extends StatefulWidget {
  const FooterWidget({super.key});

  @override
  State<FooterWidget> createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
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
        decoration: const BoxDecoration(color: Color(0xff242426)),
        width: context.mediaQuery.size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 116,
                bottom: 154,
                right: 40,
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
            footer()
          ],
        ),
      );

  tablet() => Container(
        decoration: const BoxDecoration(color: Color(0xff242426)),
        width: context.mediaQuery.size.width,
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
                location(width: context.mediaQuery.size.width * .3),
                contacts(width: context.mediaQuery.size.width * .3),
                services(width: context.mediaQuery.size.width * .3),
              ],
            ),
            footer()
          ],
        ),
      );

  mobile() => Container(
        decoration: const BoxDecoration(color: Color(0xff242426)),
        width: context.mediaQuery.size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 76, bottom: 56),
              child: logo(),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                location(width: 200),
                contacts(width: 200),
                services(width: 200),
              ],
            ),
            footer()
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
        //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        width: width,
        child: Column(
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: titleInfo('Contatos'),
            ),
            subtitleInfo('Secretaria da Igreja'),
            const SizedBox(height: 8),
            subtitleInfo('+55 (63) 3213-2775'),
            const SizedBox(height: 8),
            subtitleInfo('8h as 12h - 14h as 18h'),
          ],
        ),
      );

  location({double? width, CrossAxisAlignment? crossAxisAlignment}) =>
      Container(
        margin: const EdgeInsets.only(bottom: 32),
        //decoration: BoxDecoration(border: Border.all(color: Colors.red)),
        width: width,
        child: Column(
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: titleInfo('Localização'),
            ),
            subtitleInfo('Q. Arse 23, Av.Ns 06, Ai 09'),
            const SizedBox(height: 8),
            subtitleInfo('CEP: 77020-544'),
            const SizedBox(height: 8),
            subtitleInfo('Palmas/TO'),
          ],
        ),
      );

  services({double? width, CrossAxisAlignment? crossAxisAlignment}) =>
      Container(
        margin: const EdgeInsets.only(bottom: 118),
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

  footer() => Container(
        width: context.mediaQuery.size.width * 0.75,
        margin: const EdgeInsets.only(bottom: 60),
        child: subtitleInfo(
          'Copyright © 2023 Igreja Presbiteriana Central em Palmas/TO',
          textAlign: TextAlign.center,
        ),
      );

  titleInfo(String text, {TextAlign? textAlign}) => Text(
        text,
        style: AppFonts.defaultFont(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: const Color(0xffffffff),
        ),
      );

  subtitleInfo(String text, {TextAlign? textAlign}) => Text(
        text,
        textAlign: textAlign,
        style: AppFonts.defaultFont(
          fontSize: 14,
          color: const Color(0xffffffff),
        ),
      );
}
