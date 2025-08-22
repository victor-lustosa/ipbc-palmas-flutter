import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ServiceView extends StatefulWidget {
  const ServiceView({super.key, required this.entity});

  final ServiceEntity entity;

  @override
  State<ServiceView> createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> with DateMixin{
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ServiceTopBarWidget(
                image: widget.entity.image ?? '',
                title: "Cultos de ${widget.entity.title}",
                dateIsVisible: widget.entity.guideIsVisible,
                createAt: formatDateToString(widget.entity.createAt),
              ),
              Visibility(
                visible: widget.entity.guideIsVisible,
                child: Container(
                  margin: const EdgeInsets.only(top: 25, left: 16),
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
