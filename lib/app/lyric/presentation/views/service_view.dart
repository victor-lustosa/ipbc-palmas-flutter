import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../shared/components/button/button_widget.dart';
import '../../../shared/components/utils/responsibility_util.dart';
import '../../../shared/configs/app_configs.dart';
import '../../domain/entities/service_entity.dart';
import '../../../shared/components/guideline/guideline_widget.dart';
import '../components/lyrics_list_widget.dart';

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
  final double guideWidthPercent = 0.955;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 186,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  //    border: Border.all(color: Colors.black),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      widget.entity.image,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: const Alignment(-0.96, 0),
                      child: Container(
                        margin: const EdgeInsets.only(top: 125),
                        child: IconButtonWidget(
                          size: 32,
                          color: AppColors.white,
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          iOSIcon: CupertinoIcons.chevron_back,
                          androidIcon: Icons.arrow_back_rounded,
                          action: () => Navigator.pop(
                            context,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width *
                          ResponsibilityUtil.resolutionDeviceProportion(MediaQuery.of(context).size.width, 0.585, 0.52),
                      margin: const EdgeInsets.only(top: 126,  left: 2),
                      child: Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        widget.entity.service.title,
                        style: AppFonts.headlineServices,
                      ),
                    ),
                    Visibility(
                      visible: widget.entity.service.guideIsVisible,
                      child: Align(
                      alignment: const Alignment(0.3, 0),
                      child: Container(
                        margin: const EdgeInsets.only( top: 126),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.badgeGreen,
                            border: Border.all(color: Colors.black),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(34.7),
                            ),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 13.0, right: 13, bottom: 4, top: 4),
                            child: Text(
                              widget.entity.service.createAt,
                              style: AppFonts.liturgyBadge,
                            ),
                          ),
                        ),
                      ),
                     ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: widget.entity.service.guideIsVisible,
                child: Container(
                  margin: const EdgeInsets.only(top: 24, left: 16),
                  child: GuidelineWidget(
                      liturgyList: widget.entity.service.liturgyList),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: Platform.isIOS ? 24 : 20),
                child: Align(
                  alignment: Alignment(Platform.isIOS ? -0.4 : -0.15, 0),
                  child: SizedBox(
                    height: 25,
                    width: 350,
                    child: Align(
                      alignment: const Alignment(-1, 0),
                      child: Text(
                        "Músicas de ${widget.entity.service.heading}",
                        style: AppFonts.headline,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 24),
                child: LyricsListWidget(
                  lyricsList: widget.entity.service.lyricsList,
                ),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
