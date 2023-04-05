import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../../../shared/components/button/button_widget.dart';
import '../../../shared/configs/app_configs.dart';
import '../../../shared/configs/app_routes.dart';
import '../../domain/entities/lyric_entity.dart';

class LyricsListWidget extends StatefulWidget {
  const LyricsListWidget({Key? key, required this.lyricsList})
      : super(key: key);
  final List<LyricEntity> lyricsList;

  @override
  State<LyricsListWidget> createState() => _LyricsListWidgetState();
}

class _LyricsListWidgetState extends State<LyricsListWidget> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: const Color(0x66C8C8C8),
        highlightColor: const Color(0x66BCBCBC),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 6,
              );
            },
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: widget.lyricsList.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Material(
                borderRadius: BorderRadius.circular(10),
                clipBehavior: Clip.hardEdge,
                color: AppColors.white,
                child: ListTile(
                  horizontalTitleGap: 0,
                  contentPadding: const EdgeInsets.only(left: 11),
                  leading: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(11),
                    ),
                    child: widget.lyricsList[index].albumCover.contains("assets")
                        ? Image.asset(
                            widget.lyricsList[index].albumCover,
                            width: 50,
                            height: 80,
                          )
                        : Image.network(
                            fit: BoxFit.fill,
                            frameBuilder: (BuildContext context, Widget child,
                                int? frame, bool wasSynchronouslyLoaded) {
                              if (wasSynchronouslyLoaded) {
                                return child;
                              }
                              return Container(
                                color: AppColors.lightGrey,
                                width: 50,
                                height: 80,
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return Container(
                                color: AppColors.lightGrey,
                                width: 50,
                                height: 80,
                              );
                            },
                            widget.lyricsList[index].albumCover,
                          ),
                  ),
                  title: Container(
                    margin: const EdgeInsets.only(bottom: 4,left: 12),
                    child: Container(
                      margin: const EdgeInsets.only(right: 14),
                      child: Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        widget.lyricsList[index].title,
                        style: AppFonts.lyricsTitleTile,
                      ),
                    ),
                  ),
                  subtitle: Container(
                    margin: const EdgeInsets.only(
                         left: 12
                    ),
                    child: Text(
                      widget.lyricsList[index].group,
                      style: AppFonts.subtitleTile,
                    ),
                  ),
                  trailing:SizedBox(
                    width: 45,
                    child: IconButtonWidget(
                      size: Platform.isIOS ? null : 33,
                        color: AppColors.darkGreen,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        iOSIcon: CupertinoIcons.chevron_forward,
                        androidIcon: Icons.navigate_next_sharp,
                        action: () => Navigator.of(context, rootNavigator: true).pushNamed(
                              AppRoutes.lyricRoute,
                              arguments: widget.lyricsList[index],
                            )
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).pushNamed(
                      AppRoutes.lyricRoute,
                      arguments: widget.lyricsList[index],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
