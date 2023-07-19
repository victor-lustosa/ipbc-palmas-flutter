import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class AboutChurchWidget extends StatefulWidget {
  const AboutChurchWidget({super.key});

  @override
  State<AboutChurchWidget> createState() => _AboutChurchWidgetState();
}

class _AboutChurchWidgetState extends State<AboutChurchWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(color: Color(0xffffffff)),
          child: Container(
            margin: const EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: 100
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Uma comunidade de fé',
                          textAlign: TextAlign.center,
                          style: AppFonts.defaultFont(
                            fontSize: 56,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff242426),
                          )),
                      Container(
                        margin: const EdgeInsets.only(top: 24),
                        width: 807,
                        child: Text(
                          'A Igreja Presbiteriana Central em Palmas existe para unir o povo de Deus e ajudar sua comunidade.',
                          textAlign: TextAlign.center,
                          style: AppFonts.defaultFont(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff545456),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 960,
                  margin: const EdgeInsets.only(top: 40),
                  height: 576,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0x33005b40),
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          '',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 24,right: 24, top: 100),
          width: 1200,
          decoration: const BoxDecoration(color: Color(0xffffffff)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sobre a IPBC Palmas',
                      style: AppFonts.defaultFont(
                        fontSize: 46,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff242426),
                      ),
                    ),
                    Container(
                      margin:const EdgeInsets.only(top: 16),
                      width: 560,
                      child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse tincidunt sagittis eros. Quisque quis euismod lorem. Etiam sodales ac felis id interdum.',
                        style: AppFonts.defaultFont(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff545456),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  infoBlocs(
                    '',
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse tincidunt sagittis eros.',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  infoBlocs(
                    '',
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse tincidunt sagittis eros.',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  infoBlocs(
                    '',
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse tincidunt sagittis eros.',
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget infoBlocs(String image, String text) => SizedBox(
        height: 80,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80,
              decoration: BoxDecoration(
                color: const Color(0x33005b40),
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(image),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 24),
              width: 456,
              child: Text(
                text,
                style: AppFonts.defaultFont(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff545456),
                ),
              ),
            ),
          ],
        ),
      );
}
