import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LyricsListWidget extends StatefulWidget {
  const LyricsListWidget({Key? key, required this.entitiesList})
      : super(key: key);
  final List<LyricEntity> entitiesList;

  @override
  State<LyricsListWidget> createState() => _LyricsListWidgetState();
}

class _LyricsListWidgetState extends State<LyricsListWidget> {
  int _itemActive = 0;
  bool _elevationActive = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 25,
        left: 16,
        right: 11,
      ),
      width: context.mediaQuery.size.width,
      child: ListView.separated(
        separatorBuilder: (__, _) {
          return const SizedBox(
            height: 8,
          );
        },
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.entitiesList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (__, index) {
          return Container(
            decoration: BoxDecoration(
              boxShadow: _elevationActive && _itemActive == index
                  ? [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(1, 2),
                        spreadRadius: 3,
                        blurRadius: 10,
                      ),
                    ]
                  : [],
            ),
            child: Material(
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.hardEdge,
              color: AppColors.white,
              child: InkWell(
                onTap: () {
                  Modular.to.pushNamed(
                    '/lyrics/lyric',
                    arguments: widget.entitiesList[index],
                  );
                },
                onLongPress: () {
                  setState(() {
                    _elevationActive = true;
                    _itemActive = index;
                  });
                  showCustomOptionsDialog(
                    context: context,
                    callback: (value) {
                      setState(() {
                        _elevationActive = value;
                      });
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 8,
                    top: 8,
                    bottom: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          AlbumCoverWidget(
                            albumCover: widget.entitiesList[index].albumCover,
                            height: 48,
                            width: 48,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 8),
                                width: context.mediaQuery.size.width * .61,
                                child: Text(
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  widget.entitiesList[index].title,
                                  style: AppFonts.subhead(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.grey9,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 8),
                                child: Text(
                                  widget.entitiesList[index].group,
                                  style: AppFonts.description(
                                    color: AppColors.grey9,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButtonWidget(
                        size: 36,
                        sizeIcon: Platform.isIOS ? 29 : null,
                        color: AppColors.darkGreen,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        iOSIcon: CupertinoIcons.chevron_forward,
                        androidIcon: Icons.navigate_next_sharp,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
