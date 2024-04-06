import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServicesPreviewDTO {
  ServicesPreviewDTO({
    required this.heading,
    required this.liturgiesList,
    required this.image,
  });

  final String heading;
  final List<LiturgyEntity> liturgiesList;
  final String image;
}

class ServicesPreviewView extends StatefulWidget {
  const ServicesPreviewView({
    super.key,
    required this.dto,
  });

  final ServicesPreviewDTO dto;

  @override
  State<ServicesPreviewView> createState() => _ServicesPreviewViewState();
}

class _ServicesPreviewViewState extends State<ServicesPreviewView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: AppColors.white,
            width: context.mediaQuery.size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ServiceTopBarWidget(
                  image: widget.dto.image,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 24.7,
                    left: 16,
                  ),
                  child: GuidelineWidget(
                    circleColor: AppColors.cardBallsGrey,
                    timelineColor: AppColors.timelineGuideTGreen,
                    liturgiesList: widget.dto.liturgiesList,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 24.7,
                    left: 16,
                  ),
                  child: Text(
                    'Músicas de sábado à noite',
                    style: AppFonts.defaultFont(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: AppColors.grey10,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 4,
                    left: 16,
                    bottom: 47,
                  ),
                  child: Text(
                    'As músicas adicionadas aparecerão aqui. Adicione músicas para este culto:',
                    style: AppFonts.defaultFont(
                      fontSize: 13,
                      color: AppColors.grey8,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 15.5,
                    right: 15.5,
                    bottom: 40,
                  ),
                  child: ButtonWidget(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    fixedSize: Size(context.mediaQuery.size.width, 48),
                    action: () => Modular.to.pushNamed(
                      ServiceModule.servicesRoute +
                          ServiceModule.searchLyricsRoute,
                      arguments: EditLiturgyDTO(
                        heading: widget.dto.heading,
                        image: widget.dto.image,
                      ),
                    ),
                    backgroundColor: AppColors.darkGreen,
                    shadowColor: AppColors.grey0,
                    foregroundColor: AppColors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 16),
                          child: const Text(
                            "Incluir música ",
                          ),
                        ),
                        const IconButtonWidget(
                          size: 28,
                          iOSIcon: CupertinoIcons.chevron_forward,
                          androidIcon: Icons.navigate_next_sharp,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingButtonWidget(
        iconColor: AppColors.white,
        backgroundColor: AppColors.warning,
        pngIcon: AppIcons.editIcon,
        size: 37,
        action: () => Modular.to.pop(context),
      ),
    );
  }
}
