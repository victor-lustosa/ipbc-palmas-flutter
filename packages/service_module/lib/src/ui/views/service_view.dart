import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';

class ServiceViewDTO {
  ServiceViewDTO({required this.service, required this.image});

  final ServiceEntity service;
  final String image;
}

class ServiceView extends StatefulWidget {
  const ServiceView({super.key, required this.entity});

  final ServiceViewDTO entity;

  @override
  State<ServiceView> createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  @override
  void initState() {
    super.initState();
    setDarkAppBar();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ServiceTopBarWidget(
              image: widget.entity.image,
              title: widget.entity.service.title,
              dateIsVisible: widget.entity.service.guideIsVisible,
              createAt: DateFormat('dd/MM/yyyy')
                  .format(widget.entity.service.createAt),
            ),
            Visibility(
              visible: widget.entity.service.guideIsVisible,
              child: Container(
                margin: const EdgeInsets.only(top: 18, left: 16),
                child: GuidelineWidget(
                  circleColor: AppColors.cardBallsGrey,
                  timelineColor: AppColors.timelineGuideTGreen,
                  liturgiesList: widget.entity.service.liturgiesList,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(top: 24, left: 15, bottom: 20),
                height: 25,
                width: 350,
                child: Text(
                  "Músicas de ${widget.entity.service.heading}",
                  style: AppFonts.headline(),
                ),
              ),
            ),
            LyricsListWidget(
              entitiesList: widget.entity.service.lyricsList,
            ),
            const SizedBox(height: 40)
          ],
        ),
      ),
    );
  }
}
