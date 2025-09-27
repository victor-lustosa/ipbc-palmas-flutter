import 'package:core_module/core_module.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class LyricView extends StatefulWidget {
  const LyricView({super.key, required this.entity});

  final LyricEntity entity;

  @override
  State<LyricView> createState() => _LyricViewState();
}

class _LyricViewState extends State<LyricView> {

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16,),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 35,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 13),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    child: AlbumCoverWidget(
                                      height: 72,
                                      width: 72,
                                      albumCover: widget.entity.albumCover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: context.sizeOf.width *
                                    ResponsivityUtil.resolutionDeviceProportion(
                                        context.sizeOf.width, 0.573, 0.5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 6),
                                      child: Text(
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        widget.entity.title,
                                        style: AppFonts.defaultFont(
                                          color: AppColors.grey9,
                                          fontWeight: FontWeight.w500,
                                          fontSize: context.sizeOf.width >
                                                  ResponsivityUtil
                                                      .smallDeviceWidth
                                              ? 20
                                              : 17,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      widget.entity.group,
                                      style: AppFonts.defaultFont(
                                        color: AppColors.grey9,
                                        fontSize: context.sizeOf.width >
                                                ResponsivityUtil.smallDeviceWidth
                                            ? 15
                                            : 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(margin: EdgeInsets.only(top: 15),
                            child: IconButtonWidget(
                              size: 30,
                              color: AppColors.darkGreen,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              iOSIcon: CupertinoIcons.clear_thick,
                              androidIcon: Icons.close_rounded,
                              action: () => pop(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                     Container(
                       margin: const EdgeInsets.only(top: 28),
                       child: VersesListWidget(
                         entity: widget.entity.verses,
                       ),
                     ),
                    SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
