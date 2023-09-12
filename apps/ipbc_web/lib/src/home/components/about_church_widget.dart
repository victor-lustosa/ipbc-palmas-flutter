import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class AboutChurchWidget extends StatefulWidget {
  const AboutChurchWidget({super.key});

  @override
  State<AboutChurchWidget> createState() => _AboutChurchWidgetState();
}

class _AboutChurchWidgetState extends State<AboutChurchWidget> {

  final List<String> assetsList = [
    AppImages.hero,
    AppIcons.announce,
    AppIcons.book,
    AppIcons.volunteerActivismCube,
  ];

  final List<Image> imagesList = [];

  @override
  void initState() {
    super.initState();
    for (String imagePath in assetsList) {
      imagesList.add(Image.asset(imagePath));
    }
  }

  @override
  void didChangeDependencies() {
    for (Image entity in imagesList) {
      precacheImage(entity.image, context);
    }
    super.didChangeDependencies();
  }

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

  web() => Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: Container(
              margin: const EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: 100,
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    titlePage(fontSize: 56),
                    subtitlePage(
                      fontSize: 24,
                      width: 807,
                    ),
                    mainImage(
                      width: 960,
                      height: 576,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.03,
              right: MediaQuery.of(context).size.width * 0.03,
              top: 100,
            ),
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
                      titleAbout(fontSize: 46),
                      Container(
                        width: 560,
                        margin: const EdgeInsets.only(top: 16),
                        child: aboutChurchText(textAlign: TextAlign.start),
                      ),
                    ],
                  ),
                ),
                churchMissions(width: 555, textWidth: 445)
              ],
            ),
          )
        ],
      );

  tablet() => Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: Container(
              margin: const EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: 40,
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    titlePage(fontSize: 56),
                    subtitlePage(
                      fontSize: 24,
                      width: 807,
                    ),
                    mainImage(
                      width: 830,
                      height: 500,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.01,
              right: MediaQuery.of(context).size.width * 0.01,
              top: 100,
            ),
            width: 1200,
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                titleAbout(fontSize: 46),
                Container(
                  width: 600,
                  margin: const EdgeInsets.only(
                    top: 16,
                    bottom: 64,
                  ),
                  child: aboutChurchText(textAlign: TextAlign.center),
                ),
                Container(
                  child: churchMissions(width: 605, textWidth: 445),
                )
              ],
            ),
          )
        ],
      );

  mobile() => Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: Container(
              margin: const EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: 100,
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    titlePage(fontSize: 40),
                    subtitlePage(fontSize: 20, width: 422),
                    mainImage(height: 393),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.01,
              right: MediaQuery.of(context).size.width * 0.01,
              top: 64,
            ),
            width: 1200,
            decoration: const BoxDecoration(color: Color(0xffffffff)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                titleAbout(fontSize: 32),
                Container(
                  width: 470,
                  margin: const EdgeInsets.only(top: 16, bottom: 75),
                  child: aboutChurchText(textAlign: TextAlign.center),
                ),
                churchMissions(
                  width: 430,
                  textWidth: 300,
                  textHeight: 1.5,
                ),
              ],
            ),
          )
        ],
      );

  titlePage({required double fontSize}) => Text(
        'Uma comunidade de fé',
        textAlign: TextAlign.center,
        style: AppFonts.defaultFont(
          height: 1.5,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: const Color(0xff242426),
        ),
      );

  subtitlePage({required double fontSize, double? width}) => Container(
        margin: const EdgeInsets.only(top: 24),
        width: width,
        child: Text(
          'A Igreja Presbiteriana Central em Palmas existe para unir o povo de Deus e ajudar sua comunidade.',
          textAlign: TextAlign.center,
          style: AppFonts.defaultFont(
            height: 1.5,
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color: const Color(0xff545456),
          ),
        ),
      );

  mainImage({double? width, required double height}) => Container(
        width: width,
        height: height,
        margin: const EdgeInsets.only(top: 40),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.grey4,
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                AppImages.hero,
              ),
            ),
          ),
        ),
      );

  titleAbout({required double fontSize}) => Text(
        'Sobre a IPBC Palmas',
        style: AppFonts.defaultFont(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: const Color(0xff242426),
        ),
      );

  aboutChurchText({required TextAlign textAlign}) => Text(
        textAlign: textAlign,
        'Há 30 anos em Palmas/TO, a Igreja Presbiteriana Central de Palmas existe para servir e nutrir os membros, ajudar a sociedade e espalhar as boas notícias do Evangelho.',
        style: AppFonts.defaultFont(
          fontSize: 18,
          height: 1.5,
          fontWeight: FontWeight.w400,
          color: const Color(0xff545456),
        ),
      );

  churchMissions(
          {required double width,
          required double textWidth,
          double? textHeight}) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          cardMission(
            image: imagesList[1].image,
            text: 'Anunciar o reino de Deus',
            width: width,
            textWidth: textWidth,
          ),
          const SizedBox(height: 16),
          cardMission(
            image: imagesList[2].image,
            text: 'Educar para a vivência cristã',
            width: width,
            textWidth: textWidth,
          ),
          const SizedBox(height: 16),
          cardMission(
            image: imagesList[3].image,
            text: 'Assistir o ser humano em suas necessidades',
            width: width,
            textWidth: textWidth,
          ),
        ],
      );

  Widget cardMission(
          {required ImageProvider image,
          required String text,
          required double width,
          required double textWidth}) =>
      SizedBox(
        height: 80,
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80,
              decoration: BoxDecoration(
                color: AppColors.darkGreen,
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: image,
                ),
              ),
            ),
            Container(
              width: textWidth,
              margin: const EdgeInsets.only(left: 24),
              child: Text(
                text,
                style: AppFonts.defaultFont(
                  fontSize: 20,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff545456),
                ),
              ),
            ),
          ],
        ),
      );
}
