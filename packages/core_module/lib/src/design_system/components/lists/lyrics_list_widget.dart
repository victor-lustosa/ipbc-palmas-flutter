import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LyricsListWidget extends StatefulWidget {
  const LyricsListWidget({this.onLongPressStart, super.key, this.onTap});

  final void Function(LongPressStartDetails)? onLongPressStart;
  final void Function()? onTap;

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
      margin: const EdgeInsets.only(bottom: 25, left: 16, right: 11),
      width: context.sizeOf.width,
      child: ListView.separated(
        separatorBuilder: (__, _) {
          return const SizedBox(height: 8);
        },
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: _store.entitiesList.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (__, index) {
          final GlobalKey itemKey = GlobalKey();
          final Widget itemContent = Container(
            padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    AlbumCoverWidget(
                      albumCover: _store.entitiesList[index].albumCover,
                      height: 48,
                      width: 48,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          width: context.sizeOf.width * .61,
                          child: Text(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            _store.entitiesList[index].title,
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
                            _store.entitiesList[index].group,
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
          );

          return GestureDetector(
            key: itemKey,
            onLongPressStart: (details) async {
              _store.index = index;
              _store.itemKey = itemKey;
              _store.lyricModel = _store.entitiesList[index];
              widget.onLongPressStart?.call(details);
            },
            child: InkWell(
              onTap: () {
                _store.lyricModel = _store.entitiesList[index];
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
