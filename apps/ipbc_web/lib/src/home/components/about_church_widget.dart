import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class AboutChurchWidget extends StatefulWidget {
  const AboutChurchWidget({super.key});

  @override
  State<AboutChurchWidget> createState() => _AboutChurchWidgetState();
}

class _AboutChurchWidgetState extends State<AboutChurchWidget> {
  late double width;

  final List<String> assetsList = [
    AppIcons.announce,
    AppIcons.book,
    AppIcons.volunteerActivismCube
  ];
  late final Image heroImage;
  final List<Image> imagesList = [];

  @override
  void initState() {
    super.initState();
    heroImage = Image.network(AppImages.hero);
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
    width = context.mediaQuery.size.width;
    if (width > 1200) {
      return web();
    } else if (width > 640) {
      return tablet();
    } else {
      return mobile();
    }
  }

  web() => Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
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
              left: width * 0.03,
              right: width * 0.03,
              top: 100,
            ),
            width: 1200,
            decoration: const BoxDecoration(
              color: AppColors.white,
            ),
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
                churchMissions(
                  //width: 555,
                  width: 445,
                  insideMargin: const EdgeInsets.only(right: 24),
                )
              ],
            ),
          )
        ],
      );

  tablet() => Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
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
              left: width * 0.01,
              right: width * 0.01,
              top: 100,
            ),
            width: 1200,
            decoration: const BoxDecoration(
              color: AppColors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                titleAbout(fontSize: 46),
                Container(
                  width: 605,
                  margin: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 16,
                    bottom: 64,
                  ),
                  child: aboutChurchText(textAlign: TextAlign.center,),
                ),
                Container(
                  child: churchMissions(
                    //width: 605,
                    width: 600,
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    insideMargin: const EdgeInsets.only(right: 24),
                  ),
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
              color: AppColors.white,
            ),
            child: Container(
              margin: const EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: 80,
              ),
              child: Container(
                margin: const EdgeInsets.only(top: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    titlePage(fontSize:  width < ResponsivityUtil.smallDeviceWidth ? 34 : 40),
                    subtitlePage(fontSize: 20, width: 422),
                    mainImage(height: 393),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 84),
            width: 1200,
            decoration: const BoxDecoration(color: AppColors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                titleAbout(fontSize: 32),
                Container(
                  width: width,
                  margin: const EdgeInsets.only(
                    top: 16,
                    bottom: 75,
                    left: 20,
                    right: 20,
                  ),
                  child: aboutChurchText(
                    textAlign: TextAlign.center,
                  ),
                ),
                churchMissions(
                  fontSize: 18,
                  insideMargin: const EdgeInsets.only(right: 18),
                  margin: const EdgeInsets.symmetric(horizontal: 28),
                  width: width > 400
                      ? width * .93
                      : 450,
                  textHeight: 1.4,
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
          color: AppColors.grey12,
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
            color: AppColors.grey8,
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
            image: DecorationImage(
              fit: BoxFit.cover,
              image: heroImage.image,
            ),
          ),
        ),
      );

  titleAbout({required double fontSize}) => Text(
        'Sobre a IPBC Palmas',
        style: AppFonts.defaultFont(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          color: AppColors.grey12,
        ),
      );

  aboutChurchText({
    required TextAlign textAlign,
  }) =>
      Text(
        textAlign: textAlign,
        'Há 30 anos em Palmas/TO, a Igreja Presbiteriana Central de Palmas existe para servir e nutrir os membros, ajudar a sociedade e espalhar as boas notícias do Evangelho.',
        style: AppFonts.defaultFont(
          height: 1.4,
          color: AppColors.grey8,
        ),
      );

  churchMissions(
          { double? width,
          EdgeInsetsGeometry? margin,
          required EdgeInsetsGeometry insideMargin,
          double? fontSize,
          double? textHeight}) =>
      Container(
        margin: margin ?? EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            cardMission(
              fontSize: fontSize,
              image: imagesList[0].image,
              text: 'Anunciar o reino de Deus',
              width: width,
              insideMargin: insideMargin,
            ),
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 16),
              child: cardMission(
                fontSize: fontSize,
                insideMargin: insideMargin,
                image: imagesList[1].image,
                text: 'Educar para a vivência cristã',
                width: width,
              ),
            ),
            cardMission(
              fontSize: fontSize,
              insideMargin: insideMargin,
              image: imagesList[2].image,
              text: 'Assistir o ser humano em suas necessidades',
              width: width,
            ),
          ],
        ),
      );

  Widget cardMission(
          {required ImageProvider image,
          required String text,
           double? width,
          double? fontSize,
          required EdgeInsetsGeometry insideMargin}) =>
      SizedBox(
        height: 80,
        width: width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: insideMargin,
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
            Flexible(
              child: Text(
                text,
                softWrap: true,
                style: AppFonts.defaultFont(
                  fontSize: fontSize ?? 20,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.grey8,
                ),
              ),
            ),
          ],
        ),
      );
}
