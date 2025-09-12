import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ServiceView extends StatefulWidget {
  const ServiceView({super.key, required this.entity});

  final ServiceEntity entity;

  @override
  State<ServiceView> createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> with DateMixin {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ServiceTopBarWidget(
                image: widget.entity.image ?? '',
                title: "Cultos de ${widget.entity.title}",
                dateIsVisible: widget.entity.guideIsVisible,
                createAt: formatDateToString(widget.entity.createAt),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 4, top: 20, left: 20),
                child: Column(
                  children: [
                    Text(
                      maxLines: 2,
                      'Preletor: ${widget.entity.preacher}',
                      style: AppFonts.description(color: AppColors.grey8),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 14),
                      child: Text(
                        maxLines: 2,
                        'Mensagem: ${widget.entity.theme}',
                        style: AppFonts.description(color: AppColors.grey8),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: widget.entity.guideIsVisible,
                child: Container(
                  margin: const EdgeInsets.only(top: 20, left: 16),
                  child: GuidelineWidget(
                    circleColor: AppColors.cardBallsGrey,
                    timelineColor: AppColors.timelineGuideTGreen,
                    liturgiesList: widget.entity.liturgiesList ?? [],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(top: 24, left: 15, bottom: 20),
                  child: Text(
                    "Músicas de ${widget.entity.heading}",
                    style: AppFonts.headline(),
                  ),
                ),
              ),
              LyricsListWidget(
                entitiesList: widget.entity.lyricsList ?? [],
                onTap: () {},
                onLongPressStart: (s) {},
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
