import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 186,
                width: context.mediaQuery.size.width,
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
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 5,
                    right: 12,
                    bottom: 8,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButtonWidget(
                                size: Platform.isIOS ? null : 28,
                                color: AppColors.white,
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                iOSIcon: CupertinoIcons.chevron_back,
                                androidIcon: Icons.arrow_back_rounded,
                                action: () => Navigator.pop(context),
                              ),
                              Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                widget.entity.service.title,
                                style: AppFonts.defaultFont(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: widget.entity.service.guideIsVisible,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppColors.badgeGreen,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(34.7),
                                ),
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(
                                  left: 13,
                                  right: 13,
                                  bottom: 4,
                                  top: 4,
                                ),
                                child: Text(
                                  DateFormat('dd/MM/yyyy').format(widget.entity.service.createAt),
                                  style: AppFonts.defaultFont(
                                    color: const Color(0xFF005B40),
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: widget.entity.service.guideIsVisible,
                child: Container(
                  margin: const EdgeInsets.only(top: 18, left: 16),
                  child: GuidelineWidget(liturgyList: widget.entity.service.liturgyList),
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
              LyricsListWidget(entitiesList: widget.entity.service.lyricsList),
              const SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  }
}
