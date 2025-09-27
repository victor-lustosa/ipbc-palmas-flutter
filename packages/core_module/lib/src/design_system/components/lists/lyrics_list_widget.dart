import 'dart:io';

import 'package:core_module/core_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LyricsListWidget extends StatefulWidget {
  const LyricsListWidget({
    this.onLongPressStart,
    super.key,
    this.onTap,
    this.margin,
  });

  final void Function(LongPressStartDetails)? onLongPressStart;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;

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
      margin:
          widget.margin ??
          const EdgeInsets.only(bottom: 25, left: 16, right: 16),
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
          final Widget itemContent = Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: AlbumCoverWidget(
                        albumCover: _store.entitiesList[index].albumCover,
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
                          _store.entitiesList[index].title,
                          style: AppFonts.subhead(
                            fontWeight: FontWeight.w500,
                            color: AppColors.grey9,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          _store.entitiesList[index].group,
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
              _store.lyricEntity = _store.entitiesList[index];
              widget.onLongPressStart?.call(details);
            },
            child: InkWell(
              onTap: () {
                _store.lyricEntity = _store.entitiesList[index];
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
