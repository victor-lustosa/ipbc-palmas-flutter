import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LyricsListWidget extends StatefulWidget {
  const LyricsListWidget({this.onLongPressStart, super.key, this.onTap, required this.entitiesList});

  final void Function(LongPressStartDetails)? onLongPressStart;
  final void Function()? onTap;
  final List<LyricEntity> entitiesList;

  @override
  State<LyricsListWidget> createState() => _LyricsListWidgetState();
}

class _LyricsListWidgetState extends State<LyricsListWidget> {
  late final LyricsListStore _store;

  @override
  void initState() {
    super.initState();
    _store = Modular.get<LyricsListStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25, left: 16, right: 16),
      child: ListView.separated(
        separatorBuilder: (__, _) {
          return const SizedBox(height: 8);
        },
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.entitiesList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (__, index) {
          final GlobalKey itemKey = GlobalKey();
          final Widget itemContent = Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: AlbumCoverWidget(
                        albumCover: widget.entitiesList[index].albumCover,
                        height: 48,
                        width: 48,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          widget.entitiesList[index].title,
                          style: AppFonts.subhead(
                            fontWeight: FontWeight.w500,
                            color: AppColors.grey9,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          widget.entitiesList[index].group,
                          style: AppFonts.description(
                            color: AppColors.grey9,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  right: ResponsivityUtil.isSmallDevice(context) ? 7 : 12,
                ),
                child: IconButtonWidget(
                  size: Platform.isIOS ? 30 : 34,
                  color: AppColors.darkGreen,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  iOSIcon: CupertinoIcons.chevron_forward,
                  androidIcon: Icons.navigate_next_sharp,
                ),
              ),
            ],
          );

          return GestureDetector(
            key: itemKey,
            onLongPressStart: (details) async {
              _store.index = index;
              _store.itemKey = itemKey;
              _store.lyricModel = widget.entitiesList[index];
              widget.onLongPressStart?.call(details);
            },
            child: InkWell(
              onTap: () {
                _store.lyricModel = widget.entitiesList[index];
                widget.onTap?.call();
              },
              child: itemContent,
            ),
          );
        },
      ),
    );
  }
}
